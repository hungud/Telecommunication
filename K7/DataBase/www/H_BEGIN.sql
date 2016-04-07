CREATE OR REPLACE PROCEDURE H_BEGIN(
  pESCAPED_TITLE IN VARCHAR2
  ) IS
--#Version=1
BEGIN
  HTP.PRN('
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=' || G_STATE.PAGE_CHARSET || '">
    <TITLE>Личный кабинет - ' || pESCAPED_TITLE || '</TITLE>
    <LINK rel="stylesheet" href="help_css" type="text/css">
  </HEAD>
  <BODY>
    <TABLE BORDER=1 STYLE="margin:20px auto" ALIGN=CENTER>
      <COL WIDTH=590>
      <tr>
        <td>
          <div align=center>
            <table width="100%">
              <TR>
                <TD colspan=2 align="left" valign="top">
                  <DIV id=head_title>Личный кабинет</DIV>
                </TD>
                <TD align="right">');
--                  <IMG border="0" alt="GSM" src="IMG_LOGO" >
  HTP.PRN('                </TD>
              </TR>
            </table>
          </div>
          <hr>
        </td>
      </tr>
      <TR>
        <TD><H2>'||pESCAPED_TITLE||'</H2></TD>
      </TR>
      <TR>
        <TD>');
END H_BEGIN;
/