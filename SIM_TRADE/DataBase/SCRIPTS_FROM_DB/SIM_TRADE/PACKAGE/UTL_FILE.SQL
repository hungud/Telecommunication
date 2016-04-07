
  CREATE OR REPLACE PACKAGE "SIM_TRADE"."UTL_FILE" AUTHID CURRENT_USER AS

  /*
  ** FILE_TYPE - File handle
  */

  TYPE file_type IS RECORD (id BINARY_INTEGER,
                            datatype BINARY_INTEGER,
                            byte_mode BOOLEAN);

  /*
  ** Exceptions
  */
  file_open            EXCEPTION;
  charsetmismatch      EXCEPTION;
  invalid_path         EXCEPTION;
  invalid_mode         EXCEPTION;
  invalid_filehandle   EXCEPTION;
  invalid_operation    EXCEPTION;
  read_error           EXCEPTION;
  write_error          EXCEPTION;
  internal_error       EXCEPTION;
  invalid_maxlinesize  EXCEPTION;
  invalid_filename     EXCEPTION;
  access_denied        EXCEPTION;
  invalid_offset       EXCEPTION;
  delete_failed        EXCEPTION;
  rename_failed        EXCEPTION;

  charsetmismatch_errcode     CONSTANT PLS_INTEGER:= -29298;
  invalid_path_errcode        CONSTANT PLS_INTEGER:= -29280;
  invalid_mode_errcode        CONSTANT PLS_INTEGER:= -29281;
  invalid_filehandle_errcode  CONSTANT PLS_INTEGER:= -29282;
  invalid_operation_errcode   CONSTANT PLS_INTEGER:= -29283;
  read_error_errcode          CONSTANT PLS_INTEGER:= -29284;
  write_error_errcode         CONSTANT PLS_INTEGER:= -29285;
  internal_error_errcode      CONSTANT PLS_INTEGER:= -29286;
  invalid_maxlinesize_errcode CONSTANT PLS_INTEGER:= -29287;
  invalid_filename_errcode    CONSTANT PLS_INTEGER:= -29288;
  access_denied_errcode       CONSTANT PLS_INTEGER:= -29289;
  invalid_offset_errcode      CONSTANT PLS_INTEGER:= -29290;
  delete_failed_errcode       CONSTANT PLS_INTEGER:= -29291;
  rename_failed_errcode       CONSTANT PLS_INTEGER:= -29292;

  PRAGMA EXCEPTION_INIT(charsetmismatch,     -29298);
  PRAGMA EXCEPTION_INIT(invalid_path,        -29280);
  PRAGMA EXCEPTION_INIT(invalid_mode,        -29281);
  PRAGMA EXCEPTION_INIT(invalid_filehandle,  -29282);
  PRAGMA EXCEPTION_INIT(invalid_operation,   -29283);
  PRAGMA EXCEPTION_INIT(read_error,          -29284);
  PRAGMA EXCEPTION_INIT(write_error,         -29285);
  PRAGMA EXCEPTION_INIT(internal_error,      -29286);
  PRAGMA EXCEPTION_INIT(invalid_maxlinesize, -29287);
  PRAGMA EXCEPTION_INIT(invalid_filename,    -29288);
  PRAGMA EXCEPTION_INIT(access_denied,       -29289);
  PRAGMA EXCEPTION_INIT(invalid_offset,      -29290);
  PRAGMA EXCEPTION_INIT(delete_failed,       -29291);
  PRAGMA EXCEPTION_INIT(rename_failed,       -29292);

  /*
  ** FOPEN - open file
  **
  ** As of 8.0.6, you can have a maximum of 50 files open simultaneously.
  **
  ** As of 9.0.2, UTL_FILE allows file system access for directories
  ** created as database objects.  See the CREATE DIRECTORY command.
  ** Directory object names are case sensitive and must match exactly
  ** the NAME string in ALL_DIRECTORIES.  The LOCATION parameter may be
  ** either a directory string from the UTL_FILE_DIR init.ora parameter
  ** or a directory object name.
  **
  ** IN
  **   location     - directory location of file
  **   filename     - file name (including extention)
  **   open_mode    - open mode ('r', 'w', 'a' 'rb', 'wb', 'ab')
  **   max_linesize - maximum number of characters per line, including the
  **                  newline character, for this file.
  **                  Valid values are 1 through 32767 and NULL.  A NULL
  **                  value for max_linesize indicates that UTL_FILE should
  **                  calculate an operating system specific value at runtime.
  ** RETURN
  **   file_type handle to open file
  ** EXCEPTIONS
  **   invalid_path        - file location or name was invalid
  **   invalid_mode        - the open_mode string was invalid
  **   invalid_operation   - file could not be opened as requested
  **   invalid_maxlinesize - specified max_linesize is too large or too small
  **   access_denied       - access to the directory object is denied
  */
  FUNCTION fopen(location     IN VARCHAR2,
                 filename     IN VARCHAR2,
                 open_mode    IN VARCHAR2,
                 max_linesize IN BINARY_INTEGER DEFAULT NULL)
           RETURN file_type;
  PRAGMA RESTRICT_REFERENCES(fopen, WNDS, RNDS, TRUST);

  /*
  ** FOPEN_NCHAR - open file
  **
  ** Note: since NCHAR contains mutibyte character, it is highly recommended
  **       that the max_linesize is less than 6400.
  */

  FUNCTION fopen_nchar(location     IN VARCHAR2,
                       filename     IN VARCHAR2,
                       open_mode    IN VARCHAR2,
                       max_linesize IN BINARY_INTEGER DEFAULT NULL)
           RETURN file_type;
  PRAGMA RESTRICT_REFERENCES(fopen_nchar, WNDS, RNDS, TRUST);

  /*
  ** IS_OPEN - Test if file handle is open
  **
  ** IN
  **   file - File handle
  **
  ** RETURN
  **   BOOLEAN - Is file handle open/valid?
  */
  FUNCTION is_open(file IN file_type) RETURN BOOLEAN;
  PRAGMA RESTRICT_REFERENCES(is_open, WNDS, RNDS, WNPS, RNPS, TRUST);

  /*
  ** FCLOSE - close an open file
  **
  ** IN
  **   file - File handle (open)
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   write_error        - OS error occured during write operation
  */
  PROCEDURE fclose(file IN OUT file_type);
  PRAGMA RESTRICT_REFERENCES(fclose, WNDS, RNDS, TRUST);

  /*
  ** FCLOSE_ALL - close all open files for this session
  **
  ** For Emergency/Cleanup use only.  FILE_TYPE handles will not be
  ** cleared (IS_OPEN will still indicate they are valid)
  **
  ** IN
  **   file - File handle (open)
  ** EXCEPTIONS
  **   write_error        - OS error occured during write operation
  */
  PROCEDURE fclose_all;
  PRAGMA RESTRICT_REFERENCES(fclose_all, WNDS, RNDS, TRUST);
  /*
  ** GET_LINE - Get (read) a line of text from the file
  **
  ** IN
  **   file - File handle (open in read mode)
  **   len  - input buffer length, default is null, max is 32767
  ** OUT
  **   buffer - next line of text in file
  ** EXCEPTIONS
  **   no_data_found      - reached the end of file
  **   value_error        - line to long to store in buffer
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for reading
  **                      - file is open for byte mode access
  **   read_error         - OS error occurred during read
  **   charsetmismatch    - if the file is open for nchar data.
  */
  PROCEDURE get_line(file   IN file_type,
                     buffer OUT VARCHAR2,
                     len    IN BINARY_INTEGER DEFAULT NULL);
  PRAGMA RESTRICT_REFERENCES(get_line, WNDS, RNDS, WNPS, RNPS, TRUST);

  /* GET_LINE_NCHAR - Get (read a line of nchar data from the file.
  **
  ** IN
  **   file - File handle (open in read mode)
  **   len  - input buffer length, default is null, max is 32767
  ** OUT
  **   buffer - next line of text in file
  **            the data might be convert from UTF8 to current charset.
  ** EXCEPTIONS
  **   no_data_found      - reached the end of file
  **   value_error        - line to long to store in buffer
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for reading
  **                      - file is open for byte mode access
  **   read_error         - OS error occurred during read
  **   charsetmismatch    - if the file is open for char data.
  */
  PROCEDURE get_line_nchar(file   IN  file_type,
                           buffer OUT NVARCHAR2,
                           len    IN  BINARY_INTEGER DEFAULT NULL);
  PRAGMA RESTRICT_REFERENCES(get_line_nchar, WNDS, RNDS, WNPS, TRUST);

  /*
  ** PUT - Put (write) text to file
  **
  ** IN
  **   file   - File handle (open in write/append mode)
  **   buffer - Text to write
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **                      - file is open for byte mode access
  **   write_error        - OS error occured during write operation
  **   charsetmismatch    - if the file is open for nchar data.
  */
  PROCEDURE put(file   IN file_type,
                buffer IN VARCHAR2);
  PRAGMA RESTRICT_REFERENCES(put, WNDS, RNDS, TRUST);

  /*
  ** PUT_NCHAR - Put (write) nchar data to file
  ** IN
  **   file   - File handle (open in write/append mode)
  **   buffer - Text to write. the data will convert to UTF8 if needed.
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **                      - file is open for byte mode access
  **   write_error        - OS error occured during write operation
  **   charsetmismatch    - if the file is open for char data.
  */
  PROCEDURE put_nchar(file   IN file_type,
                buffer IN NVARCHAR2);
  PRAGMA RESTRICT_REFERENCES(put_nchar, WNDS, RNDS, TRUST);

  /*
  ** NEW_LINE - Write line terminators to file
  **
  ** IN
  **   file - File handle (open in write/append mode)
  **   lines - Number of newlines to write (default 1)
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **                      - file is open for byte mode access
  **   write_error        - OS error occured during write operation
  */
  PROCEDURE new_line(file  IN file_type,
                     lines IN NATURAL := 1);
  PRAGMA RESTRICT_REFERENCES(new_line, WNDS, RNDS, TRUST);

  /*
  ** PUT_LINE - Put (write) line to file
  **
  ** IN
  **   file      - File handle (open in write/append mode)
  **   buffer    - Text to write.
  **   autoflush - Flush following write, default=no flush
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **                      - file is open for byte mode access
  **   write_error        - OS error occured during write operation
  **   charsetmismatch    - if the file is open for nchar data.
  */
  PROCEDURE put_line(file   IN file_type,
                     buffer IN VARCHAR2,
                     autoflush IN BOOLEAN DEFAULT FALSE);
  PRAGMA RESTRICT_REFERENCES(put_line, WNDS, RNDS, TRUST);

  /*
  ** PUT_LINE_NCHAR - Put (write) line of nchar data to file
  ** IN
  **   file   - File handle (open in write/append mode)
  **   buffer - Text to write. The data might convert to UTF8 if needed.
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **                      - file is open for byte mode access
  **   write_error        - OS error occured during write operation
  **   charsetmismatch    - if the file is open for char data.
  */
  PROCEDURE put_line_nchar(file   IN file_type,
                     buffer IN NVARCHAR2);
  PRAGMA RESTRICT_REFERENCES(put_line_nchar, WNDS, RNDS, TRUST);

  /*
  ** PUTF - Put (write) formatted text to file
  **
  ** Format string special characters
  **     '%s' - substitute with next argument
  **     '\n' - newline (line terminator)
  **
  ** IN
  **   file - File handle (open in write/append mode)
  **   format - Formatting string
  **   arg1 - Substitution argument #1
  **   ...
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **                      - file is open for byte mode access
  **   write_error        - OS error occured during write operation
  **   charsetmismatch    - if the file is open for nchar data.
  */
  procedure putf(file   IN file_type,
                 format IN VARCHAR2,
                 arg1   IN VARCHAR2 DEFAULT NULL,
                 arg2   IN VARCHAR2 DEFAULT NULL,
                 arg3   IN VARCHAR2 DEFAULT NULL,
                 arg4   IN VARCHAR2 DEFAULT NULL,
                 arg5   IN VARCHAR2 DEFAULT NULL);
  PRAGMA RESTRICT_REFERENCES(putf, WNDS, RNDS, TRUST);

  /*
  ** PUTF_NCHAR - Put (write) formatted text to file
  **
  ** Format string special characters
  **     N'%s' - substitute with next argument
  **     N'\n' - newline (line terminator)
  **
  ** IN
  **   file - File handle (open in write/append mode)
  **   format - Formatting string
  **   arg1 - Substitution argument #1
  **   ...
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **                      - file is open for byte mode access
  **   write_error        - OS error occured during write operation
  **   charsetmismatch    - if the file is open for char data.

  */
  procedure putf_nchar(file   IN file_type,
                 format IN NVARCHAR2,
                 arg1   IN NVARCHAR2 DEFAULT NULL,
                 arg2   IN NVARCHAR2 DEFAULT NULL,
                 arg3   IN NVARCHAR2 DEFAULT NULL,
                 arg4   IN NVARCHAR2 DEFAULT NULL,
                 arg5   IN NVARCHAR2 DEFAULT NULL);
  PRAGMA RESTRICT_REFERENCES(putf_nchar, WNDS, RNDS, TRUST);

  /*
  ** FFLUSH - Force physical write of buffered output
  **
  ** IN
  **   file - File handle (open in write/append mode)
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **   write_error        - OS error occured during write operation
  */
  PROCEDURE fflush(file IN file_type);
  PRAGMA RESTRICT_REFERENCES(fflush, WNDS, RNDS, TRUST);

  /*
  ** PUT_RAW - Write a raw value to file.
  **
  ** IN  file      - File handle (open in write/append mode)
  ** IN  buffer    - Raw data
  ** IN  autoflush - Flush following write, default=no flush
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **   write_error        - OS error occured during write operation
  */
  PROCEDURE put_raw(file      IN file_type,
                    buffer    IN RAW,
                    autoflush IN BOOLEAN DEFAULT FALSE);
  PRAGMA RESTRICT_REFERENCES(put_raw, WNDS, RNDS, TRUST);

  /*
  ** GET_RAW - Read a raw value from file.
  **
  ** The GET_RAW() will read until it sees a line termination character
  ** or until the number of bytes specified in the LEN parameter has been read.
  **
  ** IN  file      - File handle (open in write/append mode)
  ** OUT buffer    - Raw data
  ** IN  len       - Nubmer of bytes to be read
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **   read_error         - OS error occured during read operation
  */
  PROCEDURE get_raw(file   IN  file_type,
                    buffer OUT NOCOPY RAW,
                    len    IN  BINARY_INTEGER DEFAULT NULL);
  PRAGMA RESTRICT_REFERENCES(get_raw, WNDS, RNDS, TRUST);

  /*
  ** FSEEK - Move the file pointer to a specified position within the file.
  **
  ** IN  file            - File handle (open in write/append mode)
  ** IN  absolute_offset - Absolute offset to which to seek.
  ** IN  relative_offset - Relative offset, forward or backwards, to which
  **                       to seek.
  **
  ** The file must be open in read mode in order to use fseek().
  **
  ** If both absolute_offset and relative_offset are not NULL, absolute_offset
  ** takes precedence.  A negative relative_offset will cause fseek to
  ** close and reopen the file and seek in a forward direction.
  **
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_offset     - file is not open for writing/appending
  **   invalid_operation  - file is opened for byte mode access
  */
  PROCEDURE fseek(file            IN OUT file_type,
                  absolute_offset IN     BINARY_INTEGER DEFAULT NULL,
                  relative_offset IN     BINARY_INTEGER DEFAULT NULL);
  PRAGMA RESTRICT_REFERENCES(fseek, WNDS, RNDS, TRUST);

  /*
  ** FREMOVE - Delete the specified file from disk.
  **
  ** IN  location     - directory location of file
  ** IN  filename     - file name (including extention)
  ** EXCEPTIONS
  **   invalid_path      - not a valid file handle
  **   invalid_filename  - file not found or file name NULL
  **   file_open         - file is not open for writing/appending
  **   access_denied     - access to the directory object is denied
  **   remove_failed     - failed to delete file
  */
  PROCEDURE fremove(location IN VARCHAR2,
                    filename IN VARCHAR2);
  PRAGMA RESTRICT_REFERENCES(fremove, WNDS, RNDS, TRUST);

  /*
  ** FCOPY - Copy all or part of a file to a new file.
  **
  ** IN  location     - source directory of file
  ** IN  filename     - source file name (including extention)
  ** IN  dest_dir     - destination directory of file
  ** IN  dest_file    - destination file name (including extention)
  ** IN  start_line   - line number from which to begin copying, default is
  **                         1 referring to the first line in the file
  ** IN  end_line     - line number from which to end copying, default is NULL
  **                         referring to end-of-file
  ** EXCEPTIONS
  **   invalid_path      - not a valid file handle
  **   invalid_filename  - file not found or file name is NULL
  **   invalid_lineno    - bad start_line or end_line value
  */
  PROCEDURE fcopy(src_location  IN VARCHAR2,
                  src_filename  IN VARCHAR2,
                  dest_location IN VARCHAR2,
                  dest_filename IN VARCHAR2,
                  start_line    IN BINARY_INTEGER DEFAULT 1,
                  end_line      IN BINARY_INTEGER DEFAULT NULL);
  PRAGMA RESTRICT_REFERENCES(fcopy, WNDS, RNDS, TRUST);

  /*
  ** FGETATTR - Get file attributes
  **
  ** IN  location     - directory location of file
  ** IN  filename     - file name (including extention)
  ** OUT fexists      - true or false, for exists or doesn't exist.  Note:
  **                      the following parameters have no meaning if the file
  **                      doesn't exist, in which case, they return NULL.
  ** OUT file_length  - length of the file in bytes.
  ** OUT block_size   - filesystem block size in bytes.
  ** EXCEPTIONS
  **   invalid_path      - not a valid file handle
  **   invalid_filename  - file not found or file name NULL
  **   file_open         - file is not open for writing/appending
  **   access_denied     - access to the directory object is denied
  */
  PROCEDURE fgetattr(location    IN VARCHAR2,
                     filename    IN VARCHAR2,
                     fexists     OUT BOOLEAN,
                     file_length OUT NUMBER,
                     block_size  OUT BINARY_INTEGER);
  PRAGMA RESTRICT_REFERENCES(fgetattr, WNDS, RNDS, TRUST);

  /*
  ** FGETPOS - Return the current position in the file in bytes.
  **
  ** IN  file      - File handle (open in write/append mode)
  ** EXCEPTIONS
  **   invalid_filehandle - not a valid file handle
  **   invalid_operation  - file is not open for writing/appending
  **   invalid_operation  - file is open for byte mode access
  */
  FUNCTION fgetpos(file IN file_type) RETURN BINARY_INTEGER;
  PRAGMA RESTRICT_REFERENCES(fgetpos, WNDS, RNDS, TRUST);

  /*
  ** FRENAME - Rename a file to a new name.
  **
  ** IN  location     - source directory of file
  ** IN  filename     - source file name (including extention)
  ** IN  dest_dir     - destination directory of file
  ** IN  dest_file    - destination file name (including extention)
  ** IN  overwrite    - boolean signifying whether to overwrite an existing
  **                      in the event that one exists, default  no overwrite
  ** EXCEPTIONS
  **   invalid_path      - not a valid file handle
  **   invalid_filename  - file not found or file name NULL
  **   rename_failed     - rename of the file failed
  **   access_denied     - access to the directory object is denied
  */
  PROCEDURE frename(src_location   IN VARCHAR2,
                    src_filename   IN VARCHAR2,
                    dest_location  IN VARCHAR2,
                    dest_filename  IN VARCHAR2,
                    overwrite      IN BOOLEAN DEFAULT FALSE);
  PRAGMA RESTRICT_REFERENCES(frename, WNDS, RNDS, TRUST);

END utl_file;
