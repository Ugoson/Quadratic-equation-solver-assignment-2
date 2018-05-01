.data
 msg: .asciiz "aX2 + bX + c"
 msgA: .asciiz "\nEneter value for a = "
 msgB: .asciiz "\nEneter value for b = "
 msgC: .asciiz "\nEneter value for c = "
 error: .asciiz "\nThis equation has a complex root it cannot be solved.\nTry again!!!!!!!"
 rst: .asciiz "\nThe two value for x = "
 askUser: .asciiz "\nEnter 1 to continue Or any other number to quit = "
 an: .asciiz " and "
 z: .float 0.0
 o: .float -1.0         # to convert number from positive to negetive
 f: .float 4
 t: .float 2
 one: .word 1        # for loop operation
.text
 lw $t3,one          # load word address one to $t3

 li $v0,4
 la $a0,msg
 syscall

 main:
 lwc1 $f3,z
 lwc1 $f1,o
 lwc1 $f9,t
 lwc1 $f11,f


 li $v0,4               # display message
 la $a0,msgA
 syscall

 li $v0,6               # ask user for 'a' input
 syscall
 mov.s $f6,$f0          # move floating point precision single($f0) to $f6

 li $v0,4               # display message
 la $a0,msgB
 syscall

 li $v0,6               # ask user for 'b' input
 syscall
 mov.s $f8,$f0          # move floating point precision single($f0) to $f8

 li $v0,4               # display message
 la $a0,msgC
 syscall

 li $v0,6               # ask user for 'c' input
 syscall
 mov.s $f10,$f0         # move floating point precision single($f0) to $f10

 mul.s $f13,$f8,$f8     # b^2
 mul.s $f25,$f8,$f1     # -b value
 mul.s $f15,$f6,$f10    # a*c
 mul.s $f7,$f11,$f15    # 4*a*c
 sub.s $f19,$f13,$f7    # b^2-4*a*c
 mfc1 $t1,$f19          # convert from float to integer
 bltz $t1 complexRoot   # branch if less than zero to complexRoot
 sqrt.s $f29,$f19       # sqrt(b^2-4*a*c)
 add.s $f21,$f25,$f29   # -b+sqrt(b^2-4*a*c)
 sub.s $f23,$f25,$f29   # -b-sqrt(b^2-4*a*c)
 mul.s $f17,$f9,$f6     # 2*a
 div.s $f27,$f21,$f17   # (-b+sqrt(b^2-4*a*c))/2*a
 div.s $f31,$f23,$f17   # (-b-sqrt(b^2-4*a*c))/2*a

# for result function display
 li $v0,4
 la $a0,rst             # message display
 syscall

 li $v0,2               # to print/display result
 add.s $f12,$f3,$f27
 syscall
 
 li $v0,4
 la $a0,an            # message display
 syscall

 li $v0,2              # to print/display result
 add.s $f12,$f3,$f31
 syscall
 
# branch function
 b askU

# label, for error message
 complexRoot:
 li $v0,4
 la $a0,error         # display complexRoot
 syscall

# jump function
 j main

# label, to ask user if to continue
 askU:   
 li $v0,4
 la $a0,askUser          # load address to display message
 syscall

# for return function
 li $v0,5
 syscall
 move $t0,$v0         # move register $v0 to $t0

# loop operation
 beq $t0,$t3,main     # branch to main if input = 1

# exit function
 li $v0,10
 syscall
