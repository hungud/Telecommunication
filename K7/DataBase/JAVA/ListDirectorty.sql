-- v1. 29.09.2014 ������� ���������� - ������� ListDirectory.getDirectoryList


CREATE OR REPLACE AND COMPILE JAVA SOURCE NAMED  "ListDirectory"  AS

import  oracle.sql.ARRAY;
import  oracle.sql.ArrayDescriptor;
import  oracle.sql.STRUCT;
import  oracle.sql.StructDescriptor;

import  java.sql.*;
import  java.io.*;
import  java.util.ArrayList;


/* ========================================================================================== */

public class  ListDirectory  {

    private static final  String  t_list = "T_DIRECTORY_LIST";
    private static final  String  t_item = "T_DIRECTORY_ITEM";


    /* -------------------------------------------------------------------------------------- */

    public static  ARRAY  getDirectoryList( String  directory )  throws  SQLException  {
        Connection  con = null;
        ArrayDescriptor  arrayDesc;
        ArrayList  pArrayList;

        con = DriverManager.getConnection( "jdbc:default:connection:" );
        StructDescriptor  structDesc = StructDescriptor.createDescriptor( t_item, con );
        arrayDesc = ArrayDescriptor.createDescriptor( t_list, con );
        pArrayList = new  ArrayList();
        Object[]  pRecord = new  Object[4];

        File  path = new  File( directory );
        File[]  FileList = path.listFiles();

        for  (int i = 0; i < FileList.length; i ++)  {
            pRecord[0] = FileList[i].getAbsolutePath();
            pRecord[1] = FileList[i].getName();
            pRecord[2] = new  Date( FileList[i].lastModified() );
            pRecord[3] = FileList[i].isDirectory();
            pArrayList.add( new  STRUCT( structDesc, con, pRecord ) );
        }

        return  new  ARRAY( arrayDesc, con, pArrayList.toArray() );
    }
}
/
show errors
