#include <avr/io.h>

   .section    .text
   
   .global toHex
toHex:
   push     r16
lowbyte:
   andi     r16, 0x0f
   cpi      r16, 0x0a
   brge     letter1
number1:
   ori      r16, 0x30
   mov      r17, r16
   jmp      highbyte
letter1:
   subi     r16, 0x09
   ori      r16, 0x40
   mov      r17, r16
highbyte:
   pop      r16
   lsr      r16
   lsr      r16
   lsr      r16
   lsr      r16
   andi     r16, 0x0f
   cpi      r16, 0x0a
   brge     letter2
number2:
   ori      r16, 0x30
   jmp      done
letter2:
   subi     r16, 0x09
   ori      r16, 0x40
done:
   ret
   
   .end
