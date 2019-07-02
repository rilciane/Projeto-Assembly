.data
		
		# Faça um algoritmo que leia dois valores correspondentes a anos e mostre quantos anos não bissextos existem entre eles. (A diferença entre os anos não pode ser maior que 1000)
		
		msg1:	.asciiz	"\nDigite ano inicial: "
		msg2:	.asciiz "\nDigite ano final: "
		msg3:	.asciiz "\nPeriodo invalido"
		msg4:	.asciiz "\nSoma de anos nao bissextos: "
		
		
.text
main:
		add $s5, $zero, $zero
		
		li $v0, 4
		la $a0, msg1	#lê
		syscall
			
		li $v0, 5		#escreve
		syscall
		
		add $t0, $v0, $zero		#t0 = ano inicial
		
		li $v0, 4
		la $a0, msg2	#lê
		syscall
		
		li $v0, 5		#escreve
		syscall
		
		add $t1, $v0, $zero		#t1 = ano final
		
		
		#calcular periodo
		
		sub $t2, $t1, $t0		#t2 = ano final - ano inicial
		
		add $a0, $t2, 1			# 1 a mais para contar o ano final.
		
		#condicional periodo
		
		add $s1, $zero, 1000	#s1 = 1000
		
		bgt $t2, $s1, invalido		# Se t2 > 10000 vá para invalido
		j enquanto
		
		invalido:
		
			li $v0, 4
			la $a0, msg3	#lê
			syscall
				
			li $v0, 5		#escreve
			syscall
		
			j fim
		
		enquanto:
		ble $t0, $t1, while
		j fim 
		
		while: #verificar se é ano bissexto
			rem $t3, $t0, 4 		#t3 = resto (t0/s2)
			
			rem $t4, $t0, 400		#t4 = resto (t0/s3)
			
			rem $t5, $t0, 100 		#t5 = resto (t0/s4)
			
			beq $t4, $zero, bissexto # se t4 = 0 ->bissexto -> verifica proxima
			
			beq $t3, $zero, ver2	# se t3 = 0 -> verifica proxima
			j naobissexto
			ver2:
			bne $t5, $zero, bissexto	# se t5 diferente de 0 ->bissexto
			j naobissexto	
			

			
			bissexto:
				
					j soma
				
			naobissexto:
			
				addi $s5, $s5, 1			# $s5 = 0 
					
					j soma
		
			soma:
				add $t0, $t0, 1
				j enquanto
				
fim:

	li $v0, 4
	la $a0, msg4	#lê
	syscall

	add $a0, $s5, $zero
	li $v0, 1
	syscall
	
	