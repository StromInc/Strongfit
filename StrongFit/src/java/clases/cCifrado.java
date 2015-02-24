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
        keyValue = "92AE31A79FEEB2A1".getBytes();
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
    
}