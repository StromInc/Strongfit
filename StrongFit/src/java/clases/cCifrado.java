/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Alumno
 */
public class cCifrado {
    
    private byte[] keyValue;
    private static String ALGORITHM = "AES";
    private static String padding = "AES/CBC/PKCS5Padding";
    private String [][]cBuscador;
 
    //Inicia un password en base a uno que el usuario introduzca
    public void AlgoritmoAES(String password) {
        
        String clave = "";
        for(int i = 0; i < password.length(); ++i)
        {
            if(i < 16)
            {
                clave += password.charAt(i);
            }
        }
        
        if(clave.length() < 16)
        {
            int valorN = 16 - clave.length();
            for(int i = 0; i < valorN; ++i)
            {
                clave += "0";
            }
        }
        
        keyValue = clave.getBytes();
    }

    //Inicia la clave para cifrar con el correo
    public void AlgoritmoAES()
    {
        keyValue = "92HE81A79AEXB7A9".getBytes();
    }
    
    
    //Encripta con el algoritmo aes
    public String encriptar(String valorEncriptar) throws Exception {
        Key clave = generarClave();
        byte[] iv = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        IvParameterSpec ivspec = new IvParameterSpec(iv);
        Cipher c = Cipher.getInstance(padding);
        c.init(Cipher.ENCRYPT_MODE, clave, ivspec);
        byte[] encValor = c.doFinal(valorEncriptar.getBytes());
        String valorEncriptado = new BASE64Encoder().encode(encValor);
        return valorEncriptado;
    }

    //Desencripta con el algoritmo aes
    public String desencriptar(String valorEncriptado) throws Exception {
        Key clave = generarClave();
        byte[] iv = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        IvParameterSpec ivspec = new IvParameterSpec(iv);
        Cipher c = Cipher.getInstance(padding);
        c.init(Cipher.DECRYPT_MODE, clave, ivspec);
        byte[] valorDecodificado = new BASE64Decoder().decodeBuffer(valorEncriptado);
        byte[] decValor = c.doFinal(valorDecodificado);
        String valorDesencriptado = new String(decValor);
        return valorDesencriptado;
    }

    //Genera la clave
    private Key generarClave() throws Exception {
        Key clave = new SecretKeySpec(keyValue, ALGORITHM);
        return clave;
    }
    
    //Obtiene el codigo hash para guardar la contraseña
    public String cifrarSHA1(String input) throws NoSuchAlgorithmException {
        MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
         
        return sb.toString();
    }
    
    public void iniciarBuscador(){
        cBuscador = new String[2][70];
        cBuscador[0][0] = "A";cBuscador[1][0] = "SD==";
        cBuscador[0][1] = "B";cBuscador[1][1] = "X3B";
        cBuscador[0][2] = "C";cBuscador[1][2] = "+SDX";
        cBuscador[0][3] = "D";cBuscador[1][3] = "zHA";
        cBuscador[0][4] = "E";cBuscador[1][4] = "7BD";
        cBuscador[0][5] = "F";cBuscador[1][5] = "NTH3";
        cBuscador[0][6] = "G";cBuscador[1][6] = "WED";
        cBuscador[0][7] = "H";cBuscador[1][7] = "=2C";
        cBuscador[0][8] = "I";cBuscador[1][8] = "KS2";
        cBuscador[0][9] = "J";cBuscador[1][9] = "GAV";
        cBuscador[0][10] = "K";cBuscador[1][10] = "23D";
        cBuscador[0][11] = "L";cBuscador[1][11] = "LAF";
        cBuscador[0][12] = "M";cBuscador[1][12] = "==QA";
        cBuscador[0][13] = "N";cBuscador[1][13] = "DG+";
        cBuscador[0][14] = "Ñ";cBuscador[1][14] = "MLO=";
        cBuscador[0][15] = "O";cBuscador[1][15] = "13X";
        cBuscador[0][16] = "P";cBuscador[1][16] = "ASK";
        cBuscador[0][17] = "Q";cBuscador[1][17] = "sdM";
        cBuscador[0][18] = "R";cBuscador[1][18] = "KIl";
        cBuscador[0][19] = "S";cBuscador[1][19] = "Ij0";
        cBuscador[0][20] = "T";cBuscador[1][20] = "PLA";
        cBuscador[0][21] = "U";cBuscador[1][21] = "=ms";
        cBuscador[0][22] = "V";cBuscador[1][22] = "Mos2";
        cBuscador[0][23] = "W";cBuscador[1][23] = "MOY";
        cBuscador[0][24] = "X";cBuscador[1][24] = "ax=";
        cBuscador[0][25] = "Y";cBuscador[1][25] = "sopm?";
        cBuscador[0][26] = "Z";cBuscador[1][26] = "JOC";
        cBuscador[0][27] = "a";cBuscador[1][27] = "sLS";
        cBuscador[0][28] = "b";cBuscador[1][28] = "lz=";
        cBuscador[0][29] = "c";cBuscador[1][29] = "WE2?";
        cBuscador[0][30] = "d";cBuscador[1][30] = "zL5";
        cBuscador[0][31] = "e";cBuscador[1][31] = "poV";
        cBuscador[0][32] = "f";cBuscador[1][32] = "7h9";
        cBuscador[0][33] = "g";cBuscador[1][33] = "MF7";
        cBuscador[0][34] = "h";cBuscador[1][34] = "=HUIH";
        cBuscador[0][35] = "i";cBuscador[1][35] = "OASN";
        cBuscador[0][36] = "j";cBuscador[1][36] = "JACSB";
        cBuscador[0][37] = "k";cBuscador[1][37] = "osj";
        cBuscador[0][38] = "l";cBuscador[1][38] = "8NO";
        cBuscador[0][39] = "m";cBuscador[1][39] = "jHbK";
        cBuscador[0][40] = "n";cBuscador[1][40] = "98uhs";
        cBuscador[0][41] = "ñ";cBuscador[1][41] = "KSJO";
        cBuscador[0][42] = "o";cBuscador[1][42] = "QPA";
        cBuscador[0][43] = "p";cBuscador[1][43] = "nsk=";
        cBuscador[0][44] = "q";cBuscador[1][44] = "DSVY==";
        cBuscador[0][45] = "r";cBuscador[1][45] = "HBSAHJ";
        cBuscador[0][46] = "s";cBuscador[1][46] = "VCAM==";
        cBuscador[0][47] = "t";cBuscador[1][47] = "an==";
        cBuscador[0][48] = "u";cBuscador[1][48] = "HVAJ";
        cBuscador[0][49] = "v";cBuscador[1][49] = "MLX";
        cBuscador[0][50] = "w";cBuscador[1][50] = "opM";
        cBuscador[0][51] = "x";cBuscador[1][51] = "QWIN";
        cBuscador[0][52] = "y";cBuscador[1][52] = "zakm";
        cBuscador[0][53] = "z";cBuscador[1][53] = "1298J";
        cBuscador[0][54] = "á";cBuscador[1][54] = "msal9";
        cBuscador[0][55] = "ä";cBuscador[1][55] = "nask";
        cBuscador[0][56] = "é";cBuscador[1][56] = "892Y3NN";
        cBuscador[0][57] = "ë";cBuscador[1][57] = "091JJ";
        cBuscador[0][58] = "í";cBuscador[1][58] = "893Y2ND";
        cBuscador[0][59] = "ï";cBuscador[1][59] = "3289DH";
        cBuscador[0][60] = "ó";cBuscador[1][60] = "2389HD";
        cBuscador[0][61] = "ö";cBuscador[1][61] = "WEEJW77";
        cBuscador[0][62] = "ú";cBuscador[1][62] = "OIDSN289";
        cBuscador[0][63] = "ü";cBuscador[1][63] = "dmoidw78";
        cBuscador[0][64] = "Á";cBuscador[1][64] = "dsij627";
        cBuscador[0][65] = "É";cBuscador[1][65] = "SWUHis6";
        cBuscador[0][66] = "Í";cBuscador[1][66] = "SDIHU6";
        cBuscador[0][67] = "Ó";cBuscador[1][67] = "qwpo8";
        cBuscador[0][68] = "Ú";cBuscador[1][68] = "==89h";
        cBuscador[0][69] = "Ü";cBuscador[1][69] = "+SJOI";
//        cBuscador[0][70] = "";cBuscador[1][70] = "";
//        cBuscador[0][71] = "";cBuscador[1][71] = "";
//        cBuscador[0][72] = "";cBuscador[1][72] = "";
//        cBuscador[0][73] = "";cBuscador[1][73] = "";
//        cBuscador[0][74] = "";cBuscador[1][74] = "";
//        cBuscador[0][75] = "";cBuscador[1][75] = "";
        
    }
    
    public String cifrarBuscador(String msj){
        String msjCifrado = "";
        String letra = "";
        for(int x = 0; x < msj.length(); ++x){
            letra=msj.charAt(x) + "";
            for(int i = 0; i < 70; ++i){
                if(letra.equals(cBuscador[0][i])){
                    msjCifrado += cBuscador[1][i];
                }
            }
        }
        return msjCifrado;
    }
    
    public String descifrarBuscador(String msj){
        String msjDescifrado = "";
        String letra = "";
        for(int x = 0; x < msj.length(); ++x){
            letra=msj.charAt(x) + "";
            for(int i = 0; i < 70; ++i){
                if(letra.equals(cBuscador[1][i])){
                    msjDescifrado += cBuscador[0][i];
                }
            }
        }
        return msjDescifrado;
    }
     public String sustituye(String texto, int checador){
    String cadena = "";
    for(int i = 0; i < texto.length();i++){
        if(checador == 1){
        if(texto.charAt(i) == ' '){
            cadena += '_'; 
        }else{
        cadena += texto.charAt(i);
        }
        }
        else{
        if(texto.charAt(i) == '_'){
            cadena += ' '; 
        }else{
        cadena += texto.charAt(i);
        }
        }
    }
    return cadena;
    }
    
}