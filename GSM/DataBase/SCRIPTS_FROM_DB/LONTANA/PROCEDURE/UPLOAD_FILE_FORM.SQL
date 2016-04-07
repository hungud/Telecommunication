
  CREATE OR REPLACE PROCEDURE "LONTANA"."UPLOAD_FILE_FORM" as
begin
  HTP.P('<html>
<head>
<title>test upload</title>
</head>
<body>
<FORM enctype="multipart/form-data"
action="api_load_from_1c.load_balance_change"
method="POST">
<p>Author''s Name:<INPUT type="text" name="who">
<p>Description:<INPUT type="text" name="description"><br>
<p>File to upload:<INPUT type="file" name="file"><br>
<p><INPUT type="submit">
</FORM>
</body>
</html>');
end; 