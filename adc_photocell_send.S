#include <avr/io.h>

	.section	.bss

value:	.space	1, 0
	
	.section	.text
	
	.global doit
doit:
	sbi 	_SFR_IO_ADDR(DDRB), DDB0
	sbi 	_SFR_IO_ADDR(DDRD), DDD6
	sbi	_SFR_IO_ADDR(PORTB), PORTB0
	ldi	r16, 0
	sts	OCR0A, r16
	lds	r16, TCCR0A
	ori	r16, (1<<COM0A1)|(1<<WGM01)|(1<<MUX0)
	sts	TCCR0A, r16
	lds	r16, TCCR0B
	ori	r16, (1<<CS01)
	sts	TCCR0B, r16

	lds 	r16, PRR
	andi	r16, ~(1<<PRADC)
	sts 	PRR, r16
	ldi	r16, (1<<ADLAR)|(1<<REFS0)|(1<<MUX0)
	sts	ADMUX, r16
	lds 	r16, DIDR0
	andi	r16, ~(1<<ADC0D)
	sts	DIDR0, r16
	lds	r16, ADCSRA
	ori 	r16, (1<<ADEN)|(1<<ADATE)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0)|(1<<ADPS0)|(1<<ADIE)
	andi	r16, ~(1<<ADTS2)|(1<<ADTS1)|(1<<ADTS0)
	sts	ADCSRA, r16
	lds	r16, ADCSRB
	ori	r16, (1<<ADIE)
	sts	ADCSRB, r16
	sei
	lds 	r16, ADCSRA
	ori	r16, (1<<ADSC)
	sts	ADCSRA, r16
forever:
	lds	r16, value
	call	toHex
	call	USART_send
	mov	r16, r17
	call	USART_send
	ldi	r16, '\n'
	call	USART_send
	rjmp 	forever

	.global ADC_vect
ADC_vect:
	in	   r2, _SFR_IO_ADDR(SREG)
	push	r2
	lds	r2, ADCL
	lds 	r2, ADCH
	sts	OCR0A, r2
	sts	value, r2
	pop	r2
	out	_SFR_IO_ADDR(SREG), r2
	reti

	.end
