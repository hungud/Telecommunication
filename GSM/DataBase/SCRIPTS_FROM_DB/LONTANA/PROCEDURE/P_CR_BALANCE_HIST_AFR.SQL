
  CREATE OR REPLACE PROCEDURE "LONTANA"."P_CR_BALANCE_HIST_AFR" (
   onlycontracts      IN NUMBER DEFAULT NULL,
   p_exist_contract   IN NUMBER DEFAULT NULL)
IS
   TYPE Thistory IS RECORD
   (                                           -- iot_balance_history%rowtype;
      phone         NUMBER,
      st_date       DATE,
      end_date      DATE,
      last_update   DATE,
      balance       NUMBER
   );

   history       Thistory;
   old_history   Thistory;

   CURSOR c_dbl
   IS            --все номера (и с контрактом и без) -- И все кроме Экомобайла
      SELECT DISTINCT (dbl.phone_number),
                      SYSDATE,
                      NULL,
                      SYSDATE,
                      NULL
        FROM db_loader_account_phones dbl
       WHERE DBL.ACCOUNT_ID <> 225;

   CURSOR c_contr (
      exst    NUMBER)
   IS               --курсор по контрактам (если exst!=null) то по действующим
        SELECT c.phone_number_federal,
               SYSDATE,
               NULL,
               SYSDATE,
               NULL
          FROM contracts c, contract_cancels cc
         WHERE     c.contract_id = cc.contract_id(+)
               AND (   (exst IS NOT NULL AND cc.contract_cancel_id IS NOT NULL)
                    OR exst IS NULL)
      GROUP BY c.phone_number_federal;

   CURSOR c_hist (p_phone NUMBER)
   IS                               --курсор по истории балансов с блокировкой
      SELECT bh.*
        FROM iot_balance_history bh
       WHERE bh.phone_number = p_phone AND bh.end_time IS NULL
      FOR UPDATE;
BEGIN
   IF onlycontracts IS NOT NULL
   THEN
      OPEN c_contr (p_exist_contract);
   ELSE
      OPEN c_dbl;
   END IF;

   LOOP                                                              --c_contr
      IF onlycontracts IS NOT NULL
      THEN
         FETCH c_contr INTO history;

         EXIT WHEN c_contr%NOTFOUND;
      ELSE
         FETCH c_dbl INTO history;

         EXIT WHEN c_dbl%NOTFOUND;
      END IF;

      history.balance := NVL (get_abonent_balance (history.phone), 0);

      OPEN c_hist (history.phone);

      FETCH c_hist INTO old_history;

      IF c_hist%NOTFOUND
      THEN
         INSERT INTO iot_balance_history
              VALUES history;
      ELSIF history.balance != old_history.balance
      THEN
         UPDATE iot_balance_history t
            SET t.end_time = SYSDATE
          WHERE t.phone_number = old_history.phone AND t.end_time IS NULL;

         INSERT INTO iot_balance_history
              VALUES history;
      ELSE
         UPDATE iot_balance_history t
            SET t.last_update = history.last_update
          WHERE t.phone_number = old_history.phone AND t.end_time IS NULL;
      END IF;

      COMMIT;

      CLOSE c_hist;
   END LOOP;                                                         --c_contr
END p_cr_balance_hist_afr;