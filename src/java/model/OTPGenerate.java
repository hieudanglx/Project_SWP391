/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Random;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
public class OTPGenerate {

    public static String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000); // OTP từ 100000 - 999999
        return String.valueOf(otp);
    }
}
