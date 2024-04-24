; Declaración de Registros								; PAGINA DEL DATASHEET
; ---------------------------------------------------------------------------------------
														; 92  MEMORY MAP
SYSCTL_RCGCGPIO_R		EQU 0x400FE608					; 340

GPIO_PORTB_AMSEL_R		EQU 0x40005528					; 687
GPIO_PORTB_PCTL_R		EQU 0x4000552C					; 688
GPIO_PORTB_DIR_R      	EQU	0x40005400					; 663
GPIO_PORTB_AFSEL_R    	EQU	0x40005420					; 671
GPIO_PORTB_DEN_R     	EQU	0x4000551C					; 682
GPIO_PORTB_DATA_R       EQU	0x400053FC					; 662 PB0 empieza en el bit 2 (0000 0100) = 0x04
														; 	  Por lo cual (0000 1000) = 0x08 representa a PB1  
														;     0x3FC = 0x04 + 0x08 + 0x10 + 0x20 + 0x40 + 0x80 + 0x100 + 0x200  
														
GPIO_PORTC_AMSEL_R		EQU 0x40006528					; 687
GPIO_PORTC_PCTL_R		EQU 0x4000652C					; 688
GPIO_PORTC_DIR_R      	EQU	0x40006400					; 663
GPIO_PORTC_AFSEL_R    	EQU	0x40006420					; 671
GPIO_PORTC_DEN_R     	EQU	0x4000651C					; 682
GPIO_PORTC_DATA_R       EQU	0x400063C0					; 662 PC0 empieza en el bit 2 (0000 0100) = 0x04
														; 	  Por lo cual (0100 0000) = 0x08 representa a PC4  
														;     0x30 = 0x40 + 0x80  

GPIO_PORTB_IS_R			EQU	0x40005404					; 664
GPIO_PORTB_IBE_R		EQU	0x40005408					; 665
GPIO_PORTB_IEV_R		EQU	0x4000540C					; 666
GPIO_PORTB_IM_R			EQU	0x40005410					; 667
GPIO_PORTB_RIS_R		EQU	0x40005414					; 668
GPIO_PORTB_MIS_R		EQU	0x40005418					; 669
GPIO_PORTB_ICR_R		EQU	0x4000541C					; 670
NVIC_EN0_R				EQU 0xE000E100					; 142
														; 104 TABLA DE INTERRUPCIONES
														
GPIO_PORTF_AMSEL_R     	EQU 0x40025528					; 687
GPIO_PORTF_PCTL_R      	EQU	0x4002552C					; 688
GPIO_PORTF_DIR_R      	EQU	0x40025400					; 663
GPIO_PORTF_AFSEL_R    	EQU	0x40025420					; 671
GPIO_PORTF_DEN_R      	EQU	0x4002551C					; 682
	
GPIO_PORTF_IS_R			EQU	0x40025404					; 664
GPIO_PORTF_IBE_R		EQU	0x40025408					; 665
GPIO_PORTF_IEV_R		EQU	0x4002540C					; 666
GPIO_PORTF_IM_R			EQU	0x40025410					; 667
GPIO_PORTF_RIS_R		EQU	0x40025414					; 668
GPIO_PORTF_MIS_R		EQU	0x40025418					; 669
GPIO_PORTF_ICR_R		EQU	0x4002541C					; 670
														; 104 TABLA DE INTERRUPCIONES

GPIO_PORTF_LOCK_R  		EQU 0x40025520					; 684
GPIO_PORTF_CR_R    		EQU 0x40025524					; 685
GPIO_LOCK_KEY  		    EQU 0x4C4F434B  				; 685 Unlocks the GPIO_CR register
	
GPIO_PORTF_DATA_R       EQU 0x4002503C   				; 662 PF0 empieza en el bit 2 (0000 0100) = 0x04
														; 	  Por lo cual (0001 0000) = 0x08 representa a PF1
														; 	  0x3C = 0x20 + 0x10 + 0x08 + 0x04
GPIO_PORTA_AMSEL_R		EQU 0x40004528					; 687
GPIO_PORTA_PCTL_R		EQU 0x4000452C					; 688
GPIO_PORTA_DIR_R      	EQU	0x40004400					; 663
GPIO_PORTA_AFSEL_R    	EQU	0x40004420					; 671
GPIO_PORTA_DEN_R     	EQU	0x4000451C					; 682
GPIO_PORTA_DATA_R       EQU	0x40004030					; 662 PA0 empieza en el bit 2 (0000 0100) = 0x04
														; 	  Por lo cual (0001 0000) = 0x10 representa a PA2  
														;     0x10 + 0x20 														
; ---------------------------------------------------------------------------------------																						

; Declaración de Constantes
; ---------------------------------------------------------------------------------------
CCONTAR				  	EQU 5000000
BIT_0					EQU 0x01
BIT_1					EQU 0x02
BIT_2					EQU 0x04
BIT_3					EQU 0x08
BIT_4					EQU 0x10
BIT_5					EQU 0x20
BIT_6					EQU 0x40
BIT_7					EQU 0x80
; ---------------------------------------------------------------------------------------

; Declaración de Variables
; ---------------------------------------------------------------------------------------

; ---------------------------------------------------------------------------------------

; Encabezado
; ---------------------------------------------------------------------------------------
						AREA    |.text|, CODE, READONLY, ALIGN=2
						THUMB
						EXPORT  MAIN
						EXPORT  GPIOPortB_Handler
						EXPORT  GPIOPortF_Handler
; ---------------------------------------------------------------------------------------			

; Rutina Principal
; ---------------------------------------------------------------------------------------
MAIN
						BL	CONFIGURACION
; Servo 1
						MOV R1, #BIT_4					; bit del puerto 
						LDR R2, =9500					; Tiempo en alto
						LDR R3, =10500					; Tiempo en bajo
						LDR R9, =75						; Ciclos de la señal PWM
						BL	PWM_CICLOS

						MOV R1, #BIT_4					; bit del puerto 
						LDR R2, =1500					; Tiempo en alto
						LDR R3, =18500					; Tiempo en bajo
						LDR R9, =75						; Ciclos de la señal PWM
						BL	PWM_CICLOS

						MOV R1, #BIT_4					; bit del puerto 
						LDR R2, =5500					; Tiempo en alto
						LDR R3, =14500					; Tiempo en bajo
						LDR R9, =75						; Ciclos de la señal PWM
						BL	PWM_CICLOS						

;Servo 2
						MOV R1, #BIT_5					; bit del puerto 
						LDR R2, =1900					; Tiempo en alto
						LDR R3, =18100					; Tiempo en bajo
						LDR R9, =75						; Ciclos de la señal PWM
						BL	PWM_CICLOS
						
						MOV R1, #BIT_5					; bit del puerto 
						LDR R2, =9500					; Tiempo en alto
						LDR R3, =10500					; Tiempo en bajo
						LDR R9, =75						; Ciclos de la señal PWM
						BL	PWM_CICLOS


;Servo 2 a 90°
						MOV R1, #BIT_5					; bit del puerto 
						LDR R2, =5700					; Tiempo en alto
						LDR R3, =14300					; Tiempo en bajo
						LDR R9, =75				     	; Ciclos de la señal PWM
						BL	PWM_CICLOS
LOOP
						B	LOOP
; ---------------------------------------------------------------------------------------

; Rutina de señal PWM para mover el servomotor SG90

; ---------------------------------------------------------------------------------------
PWM_CICLOS						
						SUB R9, #1
						LDR R0, =GPIO_PORTC_DATA_R		; Puerto de salida
						LDR R4, [R0]					; Parametro de puerto					
						MOV R4, R1	 					; Parametro de bit				
						STR R4, [R0]				
						MOV R10, R2						; Ciclos en tiempo alto, CLOCK = 1Mhz
TIEMPO_ALTO
						SUB R10, #1	
						CMP R10, #0	
						BNE TIEMPO_ALTO
						LDR R4, [R0]					; Parametro de puerto
						BIC R4, R1	 					; Apaga el bit	
						STR R4, [R0]				
						MOV R10, R3						; Ciclos de reloj para tiempo en bajo
TIEMPO_BAJO
						SUB R10, #1
						CMP R10, #0
						BNE TIEMPO_BAJO
						
						CMP R9, #0
						BNE PWM_CICLOS
						BX	LR
; ---------------------------------------------------------------------------------------


; Manejador de la Interrupción del PUERTO B
; ---------------------------------------------------------------------------------------
GPIOPortB_Handler
						PUSH {LR} 						
						LDR R1, =GPIO_PORTB_MIS_R
						LDR R0, [R1]
						CMP R0, #BIT_0 					; ¿PB0 interrumpió?
						BEQ INT_PB0
						CMP R0, #BIT_1 					; ¿PB1 interrumpió?
						BEQ INT_PB1
						CMP R0, #BIT_2 					; ¿PB2 interrumpió?
						BEQ INT_PB2
						CMP R0, #BIT_3 					; ¿PB3 interrumpió?
						BEQ INT_PB3
						CMP R0, #BIT_4 					; ¿PB4 interrumpió?
						BEQ INT_PB4
						CMP R0, #BIT_5 					; ¿PB5 interrumpió?
						BEQ INT_PB5
						CMP R0, #BIT_6 					; ¿PB6 interrumpió?
						BEQ INT_PB6
						CMP R0, #BIT_7 					; ¿PB7 interrumpió?
						BEQ INT_PB7
						POP {PC} 						; Recupera LR y vuelve
INT_PB0
						BIC R8, #0x20					; Establece un 0 en el bit de TEMPERATURA CALIENTE 
						ORR R8, #0x10 					; Establece un 1 en el bit de TEMPERATURA FRÍA 
						ORR R8, #0x400 					; Establece un 1 en el bit de TEMPERATURA de la sección ESTATUS
						BL	R8_VERIFICACION				; Rutina para verificar el valor de la variable global
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_0					; Limpia la interrupción
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve						


INT_PB1
						BIC R8, #0x10					; Establece un 0 en el bit de TEMPERATURA FRÍA
						ORR R8, #0x20 					; Establece un 1 en el bit de TEMPERATURA CALIENTE 
						ORR R8, #0x400 					; Establece un 1 en el bit de TEMPERATURA de la sección ESTATUS
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_1
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve

INT_PB2
						BIC R8, #0x180					; Coloca en cero los bits de TAMAÑO MEDIANO y TAMAÑO GRANDE 
						ORR R8, #0x40 					; Establece un 1 en el bit de TAMAÑO PEQUEÑO 
						ORR R8, #0x800 					; Establece un 1 en el bit de TAMAÑO de la sección ESTATUS
						MOV	R7, #0x03					; Q3 Por pagar
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_2
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve


INT_PB3
						BIC R8, #0x140					; Coloca en cero los bits de TAMAÑO PEQUEÑO y TAMAÑO GRANDE 
						ORR R8, #0x80 					; Establece un 1 en el bit de TAMAÑO MEDIANO
						ORR R8, #0x800 					; Establece un 1 en el bit de TAMAÑO de la sección ESTATUS
						MOV	R7, #0x05					; Q5 Por pagar
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_3
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve

INT_PB4
						BIC R8, #0xC0					; Coloca en cero los bits de TAMAÑO PEQUEÑO y TAMAÑO MEDIANO 
						ORR R8, #0x100 					; Establece un 1 en el bit de TAMAÑO GRANDE 
						ORR R8, #0x800 					; Establece un 1 en el bit de TAMAÑO de la sección ESTATUS
						MOV	R7, #0x07					; Q7 Por pagar
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_4
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve

INT_PB5
						ADD R6, R6, #0x01				; Suma Q1 al monto de dinero ingresado
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_5
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve

INT_PB6	
						ADD R6, R6, #0x05				; Suma Q5 al monto de dinero ingresado
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_6
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve

INT_PB7
						ADD R6, R6, #0x0A				; Suma Q10 al monto de dinero ingresado
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTB_ICR_R
						MOV R2, #BIT_7
						STR R2, [R0]
						POP {PC} 						; Recupera LR y vuelve
						

R8_VERIFICACION		
						LDR R1, =0x0E51
						CMP R8, R1
						BGE PAGO_VERIFICACION			; El valor de la variable global es mayor o igual a 0xE51
						BX	LR							; Retorna para limpiar la interrupción
PAGO_VERIFICACION						
						CMP R6, R7      				; Compara R6 y R7
						BGE PAGO_CORRECTO 			    ; Salta a rutina si R6 (monto pagado) es mayor o igual que R7 (monto por pagar)
						BX	LR
PAGO_CORRECTO
						PUSH{LR}
						CMP R6, R7      				; Compara R6 y R7
						BGT EXISTE_CAMBIO 			    ; Salta a rutina si R6 (monto pagado) es mayor que R7 (monto por pagar)
						B   NO_EXISTE_CAMBIO
EXISTE_CAMBIO						
						LDR R1, =GPIO_PORTA_DATA_R
						MOV R0, #BIT_3 					; Enciende el LED (PA3)
						STR R0, [R1]
						B	IDENTIFICAR_TIPO_BEBIDA
NO_EXISTE_CAMBIO						
						LDR R1, =GPIO_PORTA_DATA_R
						MOV R0, #BIT_2 					; Enciende el LED (PA2)
						STR R0, [R1]
IDENTIFICAR_TIPO_BEBIDA
						MOV R0, #0x0F					; Mascara para ver unicamente los bits de tipo (1111)
						AND	R8, R0						; Aplica mascara 
						CMP R8, #0x04					; 0x08 AMERICANO, 0x04 LATTE, 0x02 CHAI, 0x01 FRUTOS
						BGE ACCIONAR_SERVO_2			; TIPO CAFÉ
						B 	ACCIONAR_SERVO_1			; TIPO TÉ
						
ACCIONAR_SERVO_1
						LDR R0, =GPIO_PORTC_DATA_R		; Puerto de salida
						MOV R1, #BIT_4					; bit del puerto 
						LDR R2, =1500					; Tiempo en alto
						LDR R3, =18500					; Tiempo en bajo
						LDR R9, = 600					; Ciclos de la señal PWM
						BL  PWM_CICLOS
						LDR R2, =5500					; Tiempo en alto
						LDR R3, =14500					; Tiempo en bajo
						LDR R9, = 50					; Ciclos de la señal PWM
						BL  PWM_CICLOS
						B 	LIMPIAR_R8_R7_R6	
						
ACCIONAR_SERVO_2
						LDR R0, =GPIO_PORTC_DATA_R		; Puerto de salida
						MOV R1, #BIT_5					; bit del puerto 
						LDR R2, =1900					; Tiempo en alto
						LDR R3, =18100					; Tiempo en bajo
						LDR R9, = 600					; Ciclos de la señal PWM
						BL  PWM_CICLOS
						LDR R2, =5700					; Tiempo en alto
						LDR R3, =14300					; Tiempo en bajo
						LDR R9, = 50					; Ciclos de la señal PWM
						BL  PWM_CICLOS
						
LIMPIAR_R8_R7_R6
						LDR R1, =GPIO_PORTA_DATA_R
						BIC R0, #0x0C 					; APAGA el LED (PA2 Y PA3)
						STR R0, [R1]
						MOV R8, #0x00
						MOV R7, #0x00
						MOV R6, #0x00
						POP {LR}
						BX	LR
						
GPIOPortF_Handler
						PUSH {LR} 						
						LDR R1, =GPIO_PORTF_MIS_R
						LDR R0, [R1]
						CMP R0, #BIT_0 					; ¿PF0 interrumpió?
						BEQ INT_PF0
						CMP R0, #BIT_1 					; ¿PF1 interrumpió?
						BEQ INT_PF1
						CMP R0, #BIT_2 					; ¿PF2 interrumpió?
						BEQ INT_PF2
						CMP R0, #BIT_3 					; ¿PF3 interrumpió?
						BEQ INT_PF3
						POP {PC} 						; Recupera LR y vuelve
INT_PF0
						BIC R8, #0x0E					; Coloca en cero los bits de AMERICANO, LATTE Y CHAI 
						ORR R8, #0x01 					; Establece un 1 en el bit de TIPO FRUTOS ROJOS 
						ORR R8, #0x200 					; Establece un 1 en el bit de TIPO DE BEBIDA de la sección ESTATUS
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTF_ICR_R
						MOV R2, #BIT_0
						STR R2, [R0]
						POP {PC} 						; Retorna de la interrupción

INT_PF1
						BIC R8, #0x0D					; Coloca en cero los bits de AMERICANO, LATTE Y FRUTOS ROJOS 
						ORR R8, #0x02 					; Establece un 1 en el bit de TIPO CHAI 
						ORR R8, #0x200 					; Establece un 1 en el bit de TIPO DE BEBIDA de la sección ESTATUS
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTF_ICR_R
						MOV R2, #BIT_1
						STR R2, [R0]
						POP {PC} 						; Retorna de la interrupción
INT_PF2
						BIC R8, #0x0B					; Coloca en cero los bits de AMERICANO, CHIA Y FRUTOS ROJOS 
						ORR R8, #0x04 					; Establece un 1 en el bit de TIPO LATTE
						ORR R8, #0x200 					; Establece un 1 en el bit de TIPO DE BEBIDA de la sección ESTATUS			
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTF_ICR_R
						MOV R2, #BIT_2
						STR R2, [R0]
						POP {PC} 						; Retorna de la interrupción

INT_PF3
						BIC R8, #0x07					; Coloca en cero los bits de LATTE, CHAI Y FRUTOS ROJOS 
						ORR R8, #0x08 					; Establece un 1 en el bit de TIPO AMERICANO 
						ORR R8, #0x200 					; Establece un 1 en el bit de TIPO DE BEBIDA de la sección ESTATUS
						BL	R8_VERIFICACION
						LDR R0, =GPIO_PORTF_ICR_R
						MOV R2, #BIT_3
						STR R2, [R0]
						POP {PC} 						; Retorna de la interrupción
; ---------------------------------------------------------------------------------------

; Rutina de Configuración de Puertos, Funciones e Interrupciones
; ---------------------------------------------------------------------------------------
CONFIGURACION
; ------ Código para Habilitar el Reloj (1) de los PUERTOS B y F 
						LDR R1, =SYSCTL_RCGCGPIO_R    	; Carga la dirección de memoria de RCGCGPIO en R1
						LDR R0, [R1]                 	; Lee el valor actual del registro RCGCGPIO y lo carga en R0
 						ORR R0, #BIT_0 	              	; Habilita el PUERTO A
						ORR R0, #BIT_1 	            	; Habilita el PUERTO B
						ORR R0, #BIT_2 	              	; Habilita el PUERTO C
						ORR R0, #BIT_5 	            	; Habilita el PUERTO F
						;ORR R0, R0, #(BIT_1 | BIT_5)	; Forma alternativa habilita
						STR R0, [R1]                  	; Almacena el nuevo valor en el registro RCGCGPIO
						NOP                           	; No operación
						NOP                           	; No operación
						NOP                           	; No operación
						NOP                           	; No operación
						NOP                           	; No operación
						NOP                           	; No operación
						
; --- Configuración del PUERTO A													
; ------ Establece los pines del PUERTO A que funcionarán como SALIDAS (1)
						LDR R1, =GPIO_PORTA_DIR_R 		; Carga la dirección de memoria del GPIODIR en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIODIR y lo carga en R0
						ORR R0, #0x0C	 				; Configura el PA2 - PA3 como SALIDAS. (1100) 						
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIODIR del PUERTO B
	
; ------ Establece que pines del PUERTO A que NO estarán en modo analogico (0)
						LDR R1, =GPIO_PORTA_AMSEL_R;	; Carga la dirección de memoria de GPIOAMSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAMSEL y lo carga en R0
						BIC R0, #0x0C					; Deshabilita la función analogica de todo el PUERTO A
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAMSEL del PUERTO A
		
; ------ Establece que pines del PUERTO A NO tendrán funciones alternativas (0)
						LDR R1, =GPIO_PORTA_AFSEL_R 	; Carga la dirección de memoria del GPIOAFSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAFSEL y lo carga en R0
						BIC R0, #0x0C					; Deshabilita las funciones alternativas de todo el PUERTO A 
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAFSEL del PUERTO A
		
 ;------ Establece los pines del PUERTO A que funcionarán de proposito general (0)
						LDR R1, =GPIO_PORTA_PCTL_R 		; Carga la dirección de memoria del GPIOPCTL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOPCTL y lo carga en R0
						BIC R0, #0x00000F00				; Configura el PIN 2 del PUERTO A como GPIO. 
						BIC R0, #0x0000F000				; Configura el PIN 3 del PUERTO A como GPIO. 						
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOPCTL del PUERTO A

; ------ Establece los pines del PUERTO A que tendrán funciones digitales (1)
						LDR R1, =GPIO_PORTA_DEN_R       ; Carga la dirección de memoria del GPIODEN en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIODEN y lo carga en R0       
						ORR	R0, #0x0C	  				; Configura todo el PUERTO B como DIGITAL.
						STR R0, [R1]   					; Almacena el nuevo valor en el registro GPIODEN del PUERTO A
						
; --- Configuración del PUERTO B													
; ------ Establece los pines del PUERTO B que funcionarán como ENTRADAS (0)
						LDR R1, =GPIO_PORTB_DIR_R 		; Carga la dirección de memoria del GPIODIR en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIODIR y lo carga en R0
						BIC R0, #0xFF	 				; Configura el PB0 - PB7 como ENTRADA. 						
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIODIR del PUERTO B
	
; ------ Establece que pines del PUERTO B que NO estarán en modo analogico (0)
						LDR R1, =GPIO_PORTB_AMSEL_R;	; Carga la dirección de memoria de GPIOAMSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAMSEL y lo carga en R0
						BIC R0, #0xFF					; Deshabilita la función analogica de todo el PUERTO B
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAMSEL del PUERTO B
		
; ------ Establece que pines del PUERTO B NO tendrán funciones alternativas (0)
						LDR R1, =GPIO_PORTB_AFSEL_R 	; Carga la dirección de memoria del GPIOAFSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAFSEL y lo carga en R0
						BIC R0, #0xFF					; Deshabilita las funciones alternativas de todo el PUERTO B 
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAFSEL del PUERTO B
		
; ------ Establece los pines del PUERTO B que funcionarán de proposito general (0)
						LDR R1, =GPIO_PORTB_PCTL_R 		; Carga la dirección de memoria del GPIOPCTL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOPCTL y lo carga en R0
						BIC R0, #0x00000F00				; Configura el PIN 2 del PUERTO B como GPIO. 
						BIC R0, #0x0000F000				; Configura el PIN 3 del PUERTO B como GPIO. 						
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOPCTL del PUERTO B

; ------ Establece los pines del PUERTO B que tendrán funciones digitales (1)
						LDR R1, =GPIO_PORTB_DEN_R       ; Carga la dirección de memoria del GPIODEN en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIODEN y lo carga en R0       
						ORR	R0, #0xFF	  				; Configura todo el PUERTO B como DIGITAL.
						STR R0, [R1]   					; Almacena el nuevo valor en el registro GPIODEN del PUERTO B
						
; --- Configuración de Interrupciones del PUERTO B
; ------ Establece Detección por EDGE (0) o LEVEL (1)
						LDR R1, =GPIO_PORTB_IS_R        ; Carga la dirección de memoria del GPIOIS en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIS y lo carga en R0       
						BIC	R0, #0xFF					; Selecciona los bits del 0 al 7   
						STR R0, [R1]   					; Establece detección por edge

; ------ Establece SINGLE EDGE (0) o BOTH EDGE (1)
						LDR R1, =GPIO_PORTB_IBE_R       ; Carga la dirección de memoria del GPIOIBE en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIBE y lo carga en R0       
						BIC	R0, #0xFF					; Selecciona los bits del 0 al 7 
						STR R0, [R1]   					; Establece detección por edge simple

; ------ Establece FALLING EDGE (0) o RISISNG EDGE (1)
						LDR R1, =GPIO_PORTB_IEV_R       ; Carga la dirección de memoria del GPIOIEV en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIEV y lo carga en R0       
						BIC	R0, #0xFF					; Selecciona los bits del 0 al 7 
						STR R0, [R1] 					; Establece FALLING EDGE para todos los pines el puerto B
						
; ------ Desenmascara los bits para producir interrupciones (1)
						LDR R1, =GPIO_PORTB_IM_R        ; Carga la dirección de memoria del GPIOIM en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIM y lo carga en R0       
						ORR	R0, #0xFF					; Selecciona los bits del 0 al 7   
						STR R0, [R1] 					; Desenmascara todos los pines del puerto B

; ------ Limpia las interrupciones de los bits indicados (1)
						LDR R1, =GPIO_PORTB_ICR_R       ; Carga la dirección de memoria del GPIOIRC en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIRC y lo carga en R0       
						ORR	R0, #0xFF					; Selecciona los bits del 0 al 7   
						STR R0, [R1]   					; Limpia la interrupción en caso de existir

; --- Configuración del PUERTO C													
; ------ Establece los pines del PUERTO C que funcionarán como SALIDAS (1)
						LDR R1, =GPIO_PORTC_DIR_R 		; Carga la dirección de memoria del GPIODIR en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIODIR y lo carga en R0
						ORR R0, #0x30	 				; Configura el PC4 - PC5 como SALIDAS. (0011 0000) 						
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIODIR del PUERTO C
	
; ------ Establece que pines del PUERTO C que NO estarán en modo analogico (0)
						LDR R1, =GPIO_PORTC_AMSEL_R;	; Carga la dirección de memoria de GPIOAMSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAMSEL y lo carga en R0
						BIC R0, #0x30					; Deshabilita la función analogica de PC4 - PC5
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAMSEL del PUERTO C
		
; ------ Establece que pines del PUERTO C NO tendrán funciones alternativas (0)
						LDR R1, =GPIO_PORTC_AFSEL_R 	; Carga la dirección de memoria del GPIOAFSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAFSEL y lo carga en R0
						BIC R0, #0x30					; Deshabilita las funciones alternativas de PC4 - PC5 
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAFSEL del PUERTO C
		
 ;------ Establece los pines del PUERTO C que funcionarán de proposito general (0)
;						LDR R1, =GPIO_PORTC_PCTL_R 		; Carga la dirección de memoria del GPIOPCTL en R1
;						LDR R0, [R1]					; Lee el valor actual del registro GPIOPCTL y lo carga en R0
;						BIC R0, #0x000F0000				; Configura el PIN 4 del PUERTO C como GPIO. 
;						BIC R0, #0x00F00000				; Configura el PIN 5 del PUERTO C como GPIO. 						
;						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOPCTL del PUERTO C

; ------ Establece los pines del PUERTO C que tendrán funciones digitales (1)
						LDR R1, =GPIO_PORTC_DEN_R       ; Carga la dirección de memoria del GPIODEN en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIODEN y lo carga en R0       
						ORR	R0, #0x30	  				; Configura PC4 - PC5 como DIGITAL.
						STR R0, [R1]   					; Almacena el nuevo valor en el registro GPIODEN del PUERTO C


; --- Configuración del PUERTO F
; ------ Desbloquear el registro GPIOCR
						LDR R1, =GPIO_PORTF_LOCK_R      ; Carga la direccion para desbloquear el registro
						LDR R0, =0x4C4F434B             ; Valor que desbloquea el GPIO Port F Commit Register
						STR R0, [R1]
						
; ------ Permite que PF0 pueda ser utilizado como entrada
						LDR R1, =GPIO_PORTF_CR_R        ; Activa commit para el puerto F
						MOV R0, #0x0F                   ; PF0-PF3
						STR R0, [R1]  
	
; ------ Establece los pines del PUERTO F que funcionarán como entradas (0)
						LDR R1, =GPIO_PORTF_DIR_R 		; Carga la dirección de memoria del GPIODIR en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIODIR y lo carga en R0
						BIC R0, #0x0F	 				; Configura el PF0 - PF3 como ENTRADA. 
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIODIR del PUERTO F

; ------ Establece que pines del PUERTO F que NO estarán en modo analogico (0)
						LDR R1, =GPIO_PORTF_AMSEL_R		; Carga la dirección de memoria de GPIOAMSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAMSEL y lo carga en R0
						BIC R0, #0x0F					; Deshabilita la función analogica de PF0 - PF3
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAMSEL del PUERTO F
		
; ------ Establece que pines del PUERTO F NO tendrán funciones alternativas (0)
						LDR R1, =GPIO_PORTF_AFSEL_R 	; Carga la dirección de memoria del GPIOAFSEL en R1
						LDR R0, [R1]					; Lee el valor actual del registro GPIOAFSEL y lo carga en R0
						BIC R0, #0x0F					; Deshabilita las funciones alternativas de PF0 - PF3
						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOAFSEL del PUERTO F

; ------ Establece los pines del PUERTO F que funcionarán de proposito general (0)
;						LDR R1, =GPIO_PORTF_PCTL_R 		; Carga la dirección de memoria del GPIOPCTL en R1
;						LDR R0, [R1]					; Lee el valor actual del registro GPIOPCTL y lo carga en R0
;						BIC R0, #0x000000F0				; Configura el PIN 1 del PUERTO F como GPIO. 
;						BIC R0, #0x00000F00				; Configura el PIN 2 del PUERTO F como GPIO. 
;						STR R0, [R1]					; Almacena el nuevo valor en el registro GPIOPCTL del PUERTO F

; ------ Establece los pines del PUERTO F que tendrán funciones digitales (1)
						LDR R1, =GPIO_PORTF_DEN_R       ; Carga la dirección de memoria del GPIODEN en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIODEN y lo carga en R0       
						ORR	R0, #0x0F					; Configura el PF0 - PF3 como digital   
						STR R0, [R1]   					; Almacena el nuevo valor en el registro GPIODEN del PUERTO F
						
						
; --- Configuración de Interrupciones del PUERTO F
; ------ Establece Detección por EDGE (0) o LEVEL (1)
						LDR R1, =GPIO_PORTF_IS_R        ; Carga la dirección de memoria del GPIOIS en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIS y lo carga en R0       
						BIC	R0, #0x0F					; Selecciona los bits del 0 al 3   
						STR R0, [R1]   					; Establece detección por edge

; ------ Establece SINGLE EDGE (0) o BOTH EDGE (1)
						LDR R1, =GPIO_PORTF_IBE_R       ; Carga la dirección de memoria del GPIOIBE en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIBE y lo carga en R0       
						BIC	R0, #0x0F					; Selecciona los bits del 0 al 3 
						STR R0, [R1]   					; Establece detección por edge simple

; ------ Establece FALLING EDGE (0) o RISISNG EDGE (1)
						LDR R1, =GPIO_PORTF_IEV_R       ; Carga la dirección de memoria del GPIOIEV en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIEV y lo carga en R0       
						BIC	R0, #0x0F					; Selecciona los bits del 0 al 3 
						STR R0, [R1] 					; Establece FALLING EDGE para PF0 - PF3
						
; ------ Desenmascara los bits para producir interrupciones (1)
						LDR R1, =GPIO_PORTF_IM_R        ; Carga la dirección de memoria del GPIOIM en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIM y lo carga en R0       
						ORR	R0, #0x0F					; Selecciona los bits del 0 al 3   
						STR R0, [R1] 					; Desenmascara los pines PF0 - PF3

; ------ Limpia las interrupciones de los bits indicados (1)
						LDR R1, =GPIO_PORTF_ICR_R       ; Carga la dirección de memoria del GPIOIRC en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIRC y lo carga en R0       
						ORR	R0, #0x0F					; Selecciona los bits del 0 al 3   
						STR R0, [R1]   					; Limpia la interrupción en caso de existir
						

; ------ Activa la interrupción de los bits desenmascarados del PUERTO B y PUERTO F (1) 
						LDR R1, =NVIC_EN0_R		        ; Carga la dirección de memoria del GPIOIRC en R1
						LDR R0, [R1]             		; Lee el valor actual del registro GPIOIRC y lo carga en R0       
						ORR	R0, #0x02					; Selecciona el bit 1.    
						ORR	R0, #0x40000000				; Selecciona el bit 30.    
						STR R0, [R1]   					; Habilita la interrupción del pueto B(1) y F (30)
						
						BX	LR
						
						ALIGN

						END