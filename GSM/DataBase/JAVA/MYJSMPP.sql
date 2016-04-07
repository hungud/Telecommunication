CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED MYJSMPP as import java.io.IOException;
import java.util.Date;
import java.io.IOException;
import java.util.Arrays;

import java.sql.*;

import oracle.sql.*;
import oracle.jdbc.driver.*;

import org.jsmpp.session.*;
import org.jsmpp.InvalidResponseException;
import org.jsmpp.PDUException;
import org.jsmpp.bean.Alphabet;
import org.jsmpp.bean.BindType;
import org.jsmpp.bean.ESMClass;
import org.jsmpp.bean.GeneralDataCoding;
import org.jsmpp.bean.MessageClass;
import org.jsmpp.bean.NumberingPlanIndicator;
import org.jsmpp.bean.RegisteredDelivery;
import org.jsmpp.bean.SMSCDeliveryReceipt;
import org.jsmpp.bean.TypeOfNumber;
import org.jsmpp.extra.NegativeResponseException;
import org.jsmpp.extra.ResponseTimeoutException;
import org.jsmpp.session.BindParameter;
import org.jsmpp.session.SMPPSession;
import org.jsmpp.util.AbsoluteTimeFormatter;
import org.jsmpp.util.TimeFormatter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

//import java.sql.PreparedStatement;
//import java.sql.ResultSet;




public class MYJSMPP
{
  private static final TimeFormatter timeFormatter = new AbsoluteTimeFormatter();
  private static int query_count = 0;
  private static SMPPSession MainSession;
  
  //количество смс в секунду
  private static final int c_MAX_SMS_PER_SEC = 20;
  
  
  private static void SleepThread (int p_sms_count) throws InterruptedException
  {
    query_count = query_count + p_sms_count;
    WriteLog("query_count = " + Integer.toString(query_count));
    if (query_count >= c_MAX_SMS_PER_SEC)
    {
      query_count = 0;
      try
      {
        WriteLog("Sleep");
        Thread.sleep(1000);
      }
      catch (Exception e)
      {
        WriteLog("SleepThread error " +e.getMessage());
      }
    }
    
  }

  private static String FCHECKSMS(
                                   SMPPSession session,
                                   java.lang.String sourceAddr,
                                   java.lang.String messageId
                                 )  throws InterruptedException 
  {
    java.lang.String res = "";
    try
    {
       WriteLog("FCHECKSMS");
       SleepThread(1);
       WriteLog("messageId = "+messageId);
       QuerySmResult QRes = session.queryShortMessage(  messageId,
                                      TypeOfNumber.NETWORK_SPECIFIC,    // INTERNATIONAL,   //(byte)3 , //   TypeOfNumber sourceAddrTon
                                      NumberingPlanIndicator.PRIVATE,   // (byte)9 ,  NumberingPlanIndicator sourceAddrNpi
                                      sourceAddr);                      // String sourceAddr
            
       WriteLog("After QuerySmResult");
       org.jsmpp.bean.MessageState ms = QRes.getMessageState();

       if (ms==org.jsmpp.bean.MessageState.ENROUTE)
       {
         res = "ENROUTE";
       }
       else if (ms==org.jsmpp.bean.MessageState.DELIVERED)
       {
          res = "DELIVERED";
       }
       else if (ms==org.jsmpp.bean.MessageState.EXPIRED)
       {
          res = "EXPIRED";
       }
       else if (ms==org.jsmpp.bean.MessageState.DELETED)
       {
          res = "DELETED";
       }
       else if (ms==org.jsmpp.bean.MessageState.UNDELIVERABLE)
       {
          res = "UNDELIVERABLE";
       }
       else if (ms==org.jsmpp.bean.MessageState.ACCEPTED)
       {
          res = "ACCEPTED";
       }
       else if (ms==org.jsmpp.bean.MessageState.UNKNOWN)
       {
          res = "UNKNOWN";
       } else if (ms==org.jsmpp.bean.MessageState.REJECTED) {
         res = "REJECTED";
       }
       else
       {
          res = "UNKNOWN";
       }
          
    }
    catch (PDUException e)
    {
       res = "-10000 Invalid PDU parameter "+e.getMessage();
    }
    catch (ResponseTimeoutException e)
    {
       res = "-20000 Response timeout "+e.getMessage();
    }
    catch (InvalidResponseException e)
    {
       res = "-30000 Receive invalid respose "+e.getMessage();
    }
    catch (NegativeResponseException e)
    {
       res = "-40000 Receive negative response "+e.getMessage();
    }
    catch (IOException e)
    {
       res = "-50000 IO error occur "+e.getMessage();
    }
    return res;
  }

  private static String FsubmitMessage( SMPPSession session,
                                       java.lang.String message,
                                       org.jsmpp.bean.OptionalParameter sarMsgRefNum,
                                       org.jsmpp.bean.OptionalParameter sarSegmentSeqnum,
                                       org.jsmpp.bean.OptionalParameter sarTotalSegments,
                                       java.lang.String sourceAddr,
                                       java.lang.String serviceType,
                                       java.lang.String phone,
                                       java.lang.Integer p_is_rus,
                                       java.lang.Integer p_maxlen )
  {
      WriteLog("FsubmitMessage");
      String messageId = null;
      try {
        if (p_is_rus == 1) {
          messageId = session.submitShortMessage(
                  serviceType,                      // String serviceType  "CMT",
                  TypeOfNumber.NETWORK_SPECIFIC,
                  NumberingPlanIndicator.PRIVATE,
                  sourceAddr,
                  TypeOfNumber.INTERNATIONAL,
                  NumberingPlanIndicator.ISDN,
                  phone,
                  new ESMClass(),
                  (byte)0,
                  (byte)1,
                  timeFormatter.format(new Date()),
                  null,
                  new RegisteredDelivery(SMSCDeliveryReceipt.SUCCESS_FAILURE),
                  (byte)0,
                  new GeneralDataCoding(false, true, MessageClass.CLASS1, Alphabet.ALPHA_UCS2), //  DataCoding dataCoding
                  (byte)0,
                  message.getBytes("UTF-16BE"),
                  sarMsgRefNum,
                  sarSegmentSeqnum,
                  sarTotalSegments);
        } else {
          messageId = session.submitShortMessage(
                  serviceType,                      // String serviceType  "CMT",
                  TypeOfNumber.NETWORK_SPECIFIC,
                  NumberingPlanIndicator.PRIVATE,
                  sourceAddr,
                  TypeOfNumber.INTERNATIONAL,
                  NumberingPlanIndicator.ISDN,
                  phone,
                  new ESMClass(),
                  (byte)0,
                  (byte)1,
                  timeFormatter.format(new Date()),
                  null,
                  new RegisteredDelivery(SMSCDeliveryReceipt.SUCCESS_FAILURE),
                  (byte)0,
                  new GeneralDataCoding(false, true, MessageClass.CLASS1, Alphabet.ALPHA_DEFAULT), //  DataCoding dataCoding
                  (byte)0,
                  message.getBytes(),
                  sarMsgRefNum,
                  sarSegmentSeqnum,
                  sarTotalSegments);
        }          
      } catch (PDUException e) {
          messageId = "-10000 Invalid PDU parameter "+e.getMessage();
      } catch (ResponseTimeoutException e) {
          messageId = "-20000 Response timeout "+e.getMessage();
      } catch (InvalidResponseException e) {
          messageId = "-30000 Receive invalid respose "+e.getMessage();
      } catch (NegativeResponseException e) {
          messageId = "-40000 Receive negative response "+e.getMessage();
      } catch (IOException e) {
          messageId = "-50000 IO error occur "+e.getMessage();
      }
      return messageId;
  }

  private static String FLONGSMS( 
                                  SMPPSession session,
                                  java.lang.String sourceAddr,
                                  java.lang.String serviceType,
                                  java.lang.String phone,
                                  java.lang.String longMessage,
                                  java.lang.Integer p_is_rus,
                                  java.lang.Integer p_maxlen
                                  
                                  
                              ) throws InterruptedException
  {
      WriteLog("FLONGSMS");
      int success=1;
      int len = p_maxlen ;
      String messageId = "";
      
      if (success == 1)
      {
          java.util.Random random = new java.util.Random();

          final int totalSegments = (int) ( 1 + longMessage.length() / len );

          SleepThread(totalSegments);
          
          org.jsmpp.bean.OptionalParameter sarMsgRefNum = org.jsmpp.bean.OptionalParameters.newSarMsgRefNum((short)random.nextInt());
          org.jsmpp.bean.OptionalParameter sarTotalSegments = org.jsmpp.bean.OptionalParameters.newSarTotalSegments(totalSegments);

          int seqNum=0;
          int vStrt=0;
          int vEnd=0;
          
          
          for (int i = 0; i < totalSegments; i++) {
              seqNum = i + 1;
              vStrt = (int) (i*len) ;
              vEnd = (int) ((i+1)*len) ;
              if ( vEnd>longMessage.length() ) vEnd = longMessage.length();
              String message =  // "Message part " + seqNum + " of " + totalSegments + " from "+vStrt+" to "+vEnd+" "+
                      longMessage.substring( vStrt, vEnd );
              org.jsmpp.bean.OptionalParameter sarSegmentSeqnum = org.jsmpp.bean.OptionalParameters.newSarSegmentSeqnum(seqNum);

              messageId = messageId+" ; "+FsubmitMessage( session,
                                          message,
                                          sarMsgRefNum,
                                          sarSegmentSeqnum,
                                          sarTotalSegments,
                                          sourceAddr,
                                          serviceType,
                                          phone,
                                          p_is_rus,
                                          p_maxlen
                                        );
                                                      
              try {
                  Thread.sleep(500); // спать 1000 милисекунд.
              } catch(Exception e){
                  messageId = messageId+" ; "+"Что-то пошло не так, но бог здесь не причём, ибо его нет. Это просто какой-то косяк, который можно объяснить.";
              };                           
          }
          
      }
      return messageId;
  }
  
  
   private static String FShortSMS(
                                   SMPPSession session,
                                   java.lang.String sourceAddr,
                                   java.lang.String serviceType,
                                   java.lang.String phone,
                                   java.lang.String shortMessage,
                                   java.lang.Integer p_is_rus
                                   
                                 ) throws InterruptedException
  {
        java.lang.String messageId = "";
        WriteLog("FShortSMS");
        
        SleepThread(1);
        WriteLog("After sleep");
        try {
            if (p_is_rus == 1) {
              WriteLog("p_is_rus = 1");
              
              if (session == null)
              {
                WriteLog("Session is null");
              }
              else
              {
                WriteLog("Session is not null");
              }
              
              WriteLog("sourceAddr "+sourceAddr);
              WriteLog("serviceType "+serviceType);
              WriteLog("phone "+phone);
              WriteLog("shortMessage "+shortMessage);
              
              messageId = session.submitShortMessage(
                      serviceType,                      // String serviceType
                      TypeOfNumber.NETWORK_SPECIFIC,    // INTERNATIONAL,   //(byte)3 , //   TypeOfNumber sourceAddrTon
                      NumberingPlanIndicator.PRIVATE,   // (byte)9 ,  NumberingPlanIndicator sourceAddrNpi
                      sourceAddr,                       // String sourceAddr
                      TypeOfNumber.INTERNATIONAL,       //   TypeOfNumber destAddrTon     //  dest_addr_ton: 1
                      NumberingPlanIndicator.ISDN,      // PRIVATE,  //  NumberingPlanIndicator destAddrNpi  //  dest_addr_npi: 1
                      phone,                            // String destinationAddr
                      new ESMClass(),                   //  ESMClass esmClass
                      (byte)0,                          //  byte protocolId
                      (byte)1,                          //  byte priorityFlag
                      timeFormatter.format(new Date()), //  String scheduleDeliveryTime
                      null,                             //  String validityPeriod
                      new RegisteredDelivery(SMSCDeliveryReceipt.SUCCESS_FAILURE), //  RegisteredDelivery registeredDelivery
                      (byte)0,                          //  byte replaceIfPresentFlag
                      new GeneralDataCoding(false, true, MessageClass.CLASS1, Alphabet.ALPHA_UCS2), //  DataCoding dataCoding
                      (byte)0,                          //  byte smDefaultMsgId
                      shortMessage.getBytes("UTF-16BE")
                      ); //  byte[] shortMessage
                      
             WriteLog("After send ");         
                                                        // OptionalParameter[] optionalParameters
           } else {
               messageId = session.submitShortMessage(
                      serviceType,                      // String serviceType
                      TypeOfNumber.NETWORK_SPECIFIC,    // INTERNATIONAL,   //(byte)3 , //   TypeOfNumber sourceAddrTon
                      NumberingPlanIndicator.PRIVATE,   // (byte)9 ,  NumberingPlanIndicator sourceAddrNpi
                      sourceAddr,                       // String sourceAddr
                      TypeOfNumber.INTERNATIONAL,       //   TypeOfNumber destAddrTon     //  dest_addr_ton: 1
                      NumberingPlanIndicator.ISDN,      // PRIVATE,  //  NumberingPlanIndicator destAddrNpi  //  dest_addr_npi: 1
                      phone,                            // String destinationAddr
                      new ESMClass(),                   //  ESMClass esmClass
                      (byte)0,                          //  byte protocolId
                      (byte)1,                          //  byte priorityFlag
                      timeFormatter.format(new Date()), //  String scheduleDeliveryTime
                      null,                             //  String validityPeriod
                      new RegisteredDelivery(SMSCDeliveryReceipt.SUCCESS_FAILURE), //  RegisteredDelivery registeredDelivery
                      (byte)0,                          //  byte replaceIfPresentFlag
                      new GeneralDataCoding(false, true, MessageClass.CLASS1, Alphabet.ALPHA_DEFAULT), //  DataCoding dataCoding
                      (byte)0,                          //  byte smDefaultMsgId
                      shortMessage.getBytes()); //  byte[] shortMessage
                                                        // OptionalParameter[] optionalParameters
            }
        } catch (PDUException e) {
            messageId = "-10000 Invalid PDU parameter "+e.getMessage();
        } catch (ResponseTimeoutException e) {
            messageId = "-20000 Response timeout "+e.getMessage();
        } catch (InvalidResponseException e) {
            messageId = "-30000 Receive invalid respose "+e.getMessage();
        } catch (NegativeResponseException e) {
            messageId = "-40000 Receive negative response "+e.getMessage();
        } catch (IOException e) {
            messageId = "-50000 IO error occur "+e.getMessage();
        }
        WriteLog("messageId "+ messageId);
        return messageId;
  }

  public static void WriteLog (String message)
  {
    /*
    Date date = new Date();
    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                 
    //to convert Date to String, use format method of SimpleDateFormat class.
    String strDate = dateFormat.format(date);
    //System.out.println("****************************************");                 
    //System.out.println(strDate);
    
    System.out.println("date: " + strDate +" message: "+message);
    */
  }
  public static void CreateSession (String host,
                                      String pport,
                                      String user,
                                      String passw)
  throws java.sql.SQLException,IOException, InterruptedException                                      
  {
     WriteLog("Start work");
    try
    {
      if (MainSession == null)
      {
        int port = Integer.parseInt(pport);
      
        
        MainSession = new SMPPSession();
        
        MainSession.setTransactionTimer(60000);
                    
        MainSession.connectAndBind(host,
                                  port,
                                  new BindParameter( BindType.BIND_TX,
                                        user,
                                        passw,
                                        "cp",
                                        TypeOfNumber.UNKNOWN,
                                        NumberingPlanIndicator.UNKNOWN,
                                        null)
                                );
        WriteLog("Connect Good");                            
      }
    }
    catch (Exception e)
    {
       WriteLog("Error "+e.getMessage());
    }
    
  }
  
  public static void SEND_CHECK_STATUS_SMS()
  throws java.sql.SQLException,IOException, InterruptedException
  {
    /*
    String[] v_phone = (String[])p_phone.getArray();
    String[] v_message = (String[])p_message.getArray();
    String[] v_message_id = (String[])p_message_id.getArray();
    String[] v_status_code = (String[])p_status_code.getArray();
    String [] v_tmpArr;
    */ 
    final String sourceAddr = "&GSMCorp";
    final String serviceType = "CMT";
    
    final String SQL_NEW_SORT = "select * from( \r\n"+
                                 " SELECT ROWIDTOCHAR(ROWID) P_ROWID , \r\n"+
                                 "        sc.provider_id, \r\n"+
                                 "        sc.phone phone, \r\n"+
                                 "        sc.MESSAGE, \r\n"+
                                 "        sc.sms_id, \r\n"+
                                 "        sc.status_code, \r\n"+
                                 "        sc.ERROR_CODE, \r\n"+
                                 "        nvl(sc.req_count, 0) req_count, \r\n"+
                                 "        sc.insert_date, \r\n"+
                                 "        sc.update_date, \r\n"+
                                 "        sc.result_str, \r\n"+
                                 "        sc.description_str, \r\n"+
                                 "        sc.date_start, \r\n"+
                                 "        SC.SMS_SENDER_NAME \r\n"+
                                 "   FROM SMS_CURRENT SC  \r\n"+
                                 "  WHERE     sc.date_start <= SYSDATE  \r\n"+
                                 "        --AND (   (MOD (TO_NUMBER (PHONE), cMAX_STREAM_COUNT) = pStreamID) \r\n"+
                                 "       --      OR (pStreamID = -1)) \r\n"+
                                 "        AND (   (    sc.status_code = 99 \r\n"+
                                 "                 AND (   sc.ERROR_CODE = 0 \r\n"+
                                 "                      OR sc.ERROR_CODE IS NULL \r\n"+
                                 "                      OR (    sc.ERROR_CODE IN (6, \r\n"+
                                 "                                                7, \r\n"+
                                 "                                                43, \r\n"+
                                 "                                                40) \r\n"+
                                 "                          AND sc.update_date < SYSDATE - 1 / 1440 / 2)) \r\n"+
                                 "                 AND ? IN (0, 1) --0 чтоб работало как и раньше, 1 - только новые смс \r\n"+
                                 "                                      ) \r\n"+
                                 "             OR (    sc.status_code IN (0, 1) \r\n"+
                                 "                 AND sc.update_date < SYSDATE - 1 / 1440 / 2  \r\n"+
                                 "                 AND ? IN (0, 2) --0 чтоб работало как и раньше, 2 - только опрашивать статус смс \r\n"+
                                 "                 and SC.update_date <  sysdate-8/24/60 --статусы проверяем тольоко у смс с датой обновления более 8 минут назад \r\n"+
                                 "                 )) \r\n"+
                                 " ORDER BY status_code desc, insert_date desc \r\n"+
                                " ) \r\n"+
                                "--where --rownum <= 1";
    int i;
    int v_chr;
    int v_maxlen;
    int v_is_rus;
    String pANSWER;
    pANSWER = "";
    String tmpMessage;
    String tmpSmsId;
    String tmpPhone;
    String tmpStatusCode;
    int tmp_req_count;
    CallableStatement procin;
    
    tmp_req_count = 0;
    i = 0;

    
    
    ResultSet rs;
    Connection conn = new OracleDriver().defaultConnection();
    
    PreparedStatement p = conn.prepareStatement(SQL_NEW_SORT);
    
    p.setInt(1, 0);
    p.setInt(2, 0);
     
    rs = p.executeQuery();
    
    CreateSession ( "217.118.84.12", "3340", "717100", "O6q^>W)\\");
    
    //WriteLog("SQL_NEW_SORT"+SQL_NEW_SORT);
    
    while ( rs.next() )
    {
      tmpMessage = rs.getString("MESSAGE");
      tmpPhone = "7" + rs.getString("phone");
      tmp_req_count = Integer.parseInt(rs.getString("req_count"));
      tmpStatusCode = rs.getString("status_code");
      
      try
      {
        tmpSmsId = rs.getString("sms_id");
      }
      catch (Exception e)
      {
        tmpSmsId = "";
      }
        
      
      try
      {
         if (MainSession == null)
         { 
          WriteLog("Session is null");
         }
         else
         {
          WriteLog("Session is not null");
         }
                          
        //for(i = 0; i < p_phone.length(); i++)
        //{
                              
          if (tmpStatusCode.equals("99"))
          {
            v_is_rus = 0;
            v_maxlen = 140;
                        
            //определеляем длину смс
            for (int j = 0; j < tmpMessage.length(); j++)
            {
              v_chr = (int) tmpMessage.charAt(i);
                                  
              if (( v_chr > 128 ) || ( v_chr <32))
              {
                v_is_rus = 1;
                v_maxlen = 70;
                break;
              }
            }
                                
            if (tmpMessage.length() < v_maxlen)
            {
                           
               pANSWER = FShortSMS(
                                         MainSession,
                                         sourceAddr,
                                         serviceType,
                                         tmpPhone,
                                         tmpMessage,
                                         v_is_rus
                                       );
                          
            }
            else
            {
              if (v_is_rus == 1)
              {
                v_maxlen = 66;
              }
                                 
              pANSWER =  FLONGSMS( 
                                        MainSession,
                                        sourceAddr,
                                        serviceType,
                                        tmpPhone,
                                        tmpMessage,
                                        v_is_rus,
                                        v_maxlen
                                      );
                                                         
             //query_count - увеличивается в функции FLONGSMS        
            } 
          }//v_status_code[i]== "99"
          else
          {
                        
            pANSWER = FCHECKSMS( 
                                        MainSession,
                                        sourceAddr,
                                        tmpSmsId
                                      );
                                                   
          }//v_status_code[i]!= "99"
                              
       
                          
                  
       WriteLog("Message sended Res="+pANSWER);
                          
      }//end try
      catch (Exception e)
      {
         pANSWER = "Error main"+e.getMessage();
         WriteLog(pANSWER);
      }
      finally
      {
                        
      }//end
      
     
      procin = conn.prepareCall ("begin UPDATE_SMS_STATE (?, ?); end;");
      procin.setString (1, rs.getString("P_ROWID"));
      procin.setString (2, pANSWER);
      procin.execute ();
      procin.close();
                 
    }//end while
    
    conn.close();
    
    if (MainSession != null)
    {
      DisconnectSession();
    }
  
  }//end SEND_CHECK_STATUS_SMS
  
  public static void DisconnectSession ()
  {
    MainSession.unbindAndClose();
    WriteLog("Disconnect Good");
    WriteLog("End work");       
  }
}
/

