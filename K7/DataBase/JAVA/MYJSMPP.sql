CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED MYJSMPP as import java.io.IOException;
import java.util.Date;

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

public class MYJSMPP
{
  private static final TimeFormatter timeFormatter = new AbsoluteTimeFormatter();

  public static String FShortSMS(  java.lang.String host,
                                   java.lang.String pport,
                                   java.lang.String user,
                                   java.lang.String passw,
                                   java.lang.String sourceAddr,
                                   java.lang.String serviceType,
                                   java.lang.String phone,
                                   java.lang.String shortMessage,
                                   java.lang.String p_is_rus,
                                   java.lang.String p_maxlen
                                 )
  {
        int port = Integer.parseInt(pport);
        SMPPSession session;
        java.lang.String messageId = "";
        try {
            session = new SMPPSession();
            session.connectAndBind( host,
                                    port,
                                    new BindParameter( BindType.BIND_TX,
                                            user,
                                            passw,
                                            "cp", TypeOfNumber.UNKNOWN, NumberingPlanIndicator.UNKNOWN, null));
            if (p_is_rus.equals("1")) {                             
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
                      new RegisteredDelivery(SMSCDeliveryReceipt.DEFAULT), //  RegisteredDelivery registeredDelivery
                      (byte)0,                          //  byte replaceIfPresentFlag
                      new GeneralDataCoding(false, true, MessageClass.CLASS1, Alphabet.ALPHA_UCS2), //  DataCoding dataCoding
                      (byte)0,                          //  byte smDefaultMsgId
                      shortMessage.getBytes("UTF-16BE")); //  byte[] shortMessage
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
                      new RegisteredDelivery(SMSCDeliveryReceipt.DEFAULT), //  RegisteredDelivery registeredDelivery
                      (byte)0,                          //  byte replaceIfPresentFlag
                      new GeneralDataCoding(false, true, MessageClass.CLASS1, Alphabet.ALPHA_DEFAULT), //  DataCoding dataCoding
                      (byte)0,                          //  byte smDefaultMsgId
                      shortMessage.getBytes()); //  byte[] shortMessage
                                                        // OptionalParameter[] optionalParameters
            }                                          
            session.unbindAndClose();
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

  public static String FCHECKSMS(  java.lang.String host,
                                   java.lang.String pport,
                                   java.lang.String user,
                                   java.lang.String passw,
                                   java.lang.String sourceAddr,
                                   java.lang.String messageId
                                 )
  {
        int port = Integer.parseInt(pport);
        SMPPSession session;
        java.lang.String res = "";
        try {
            session = new SMPPSession();
            session.connectAndBind( host,
                                    port,
                                    new BindParameter( BindType.BIND_TX,
                                            user,
                                            passw,
                                            "cp", TypeOfNumber.UNKNOWN, NumberingPlanIndicator.UNKNOWN, null));

            QuerySmResult QRes = session.queryShortMessage(  messageId,
                                      TypeOfNumber.NETWORK_SPECIFIC,    // INTERNATIONAL,   //(byte)3 , //   TypeOfNumber sourceAddrTon
                                      NumberingPlanIndicator.PRIVATE,   // (byte)9 ,  NumberingPlanIndicator sourceAddrNpi
                                      sourceAddr);                      // String sourceAddr
            org.jsmpp.bean.MessageState ms = QRes.getMessageState();

            if (ms==org.jsmpp.bean.MessageState.ENROUTE) {
               res = "ENROUTE";
            } else if (ms==org.jsmpp.bean.MessageState.DELIVERED) {
               res = "DELIVERED";
            } else if (ms==org.jsmpp.bean.MessageState.EXPIRED) {
               res = "EXPIRED";
            } else if (ms==org.jsmpp.bean.MessageState.DELETED) {
               res = "DELETED";
            } else if (ms==org.jsmpp.bean.MessageState.UNDELIVERABLE) {
               res = "UNDELIVERABLE";
            } else if (ms==org.jsmpp.bean.MessageState.ACCEPTED) {
               res = "ACCEPTED";
            } else if (ms==org.jsmpp.bean.MessageState.UNKNOWN) {
               res = "UNKNOWN";
            } else if (ms==org.jsmpp.bean.MessageState.REJECTED) {
               res = "REJECTED";
            } else {
               res = "UNKNOWN";
            }
            session.unbindAndClose();
        } catch (PDUException e) {
            res = "-10000 Invalid PDU parameter "+e.getMessage();
        } catch (ResponseTimeoutException e) {
            res = "-20000 Response timeout "+e.getMessage();
        } catch (InvalidResponseException e) {
            res = "-30000 Receive invalid respose "+e.getMessage();
        } catch (NegativeResponseException e) {
            res = "-40000 Receive negative response "+e.getMessage();
        } catch (IOException e) {
            res = "-50000 IO error occur "+e.getMessage();
        }
        return res;
  }

  public static String FsubmitMessage( SMPPSession session,
                                       java.lang.String message,
                                       org.jsmpp.bean.OptionalParameter sarMsgRefNum,
                                       org.jsmpp.bean.OptionalParameter sarSegmentSeqnum,
                                       org.jsmpp.bean.OptionalParameter sarTotalSegments,
                                       java.lang.String sourceAddr,
                                       java.lang.String serviceType,
                                       java.lang.String phone,
                                       java.lang.String p_is_rus,
                                       java.lang.String p_maxlen )
  {
      String messageId = null;
      try {
        if (p_is_rus.equals("1")) {
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
                  new RegisteredDelivery(SMSCDeliveryReceipt.DEFAULT),
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
                  new RegisteredDelivery(SMSCDeliveryReceipt.DEFAULT),
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

  public static String FLONGSMS(  java.lang.String host,
                                  java.lang.String pport,
                                  java.lang.String user,
                                  java.lang.String passw,
                                  java.lang.String sourceAddr,
                                  java.lang.String serviceType,
                                  java.lang.String phone,
                                  java.lang.String longMessage,
                                  java.lang.String p_is_rus,
                                  java.lang.String p_maxlen
                              )
  {
      int port = Integer.parseInt(pport);
      SMPPSession session;
      int success=1;
      int len = Integer.parseInt(p_maxlen) ;
      String messageId = "";
      session = new SMPPSession();
      try {
          session.connectAndBind( host,
                                  port,
                                  new BindParameter( BindType.BIND_TX,
                                          user,
                                          passw,
                                          "cp", TypeOfNumber.UNKNOWN, NumberingPlanIndicator.UNKNOWN, null));
          success = 1;
      } catch (IOException e) {
          success = 0;
          messageId = "-1 Failed connect and bind to host";
      }
      if (success == 1)
      {
          java.util.Random random = new java.util.Random();

          final int totalSegments = (int) ( 1 + longMessage.length() / len );

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
                  Thread.sleep(200); // спать 1000 милисекунд.
              } catch(Exception e){
                  messageId = messageId+" ; "+"Что-то пошло не так, но бог здесь не причём, ибо его нет. Это просто какой-то косяк, который можно объяснить.";
              };                           
          }
          session.unbindAndClose();
      }
      return messageId;
  }
}
/

