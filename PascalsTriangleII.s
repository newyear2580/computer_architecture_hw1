            .data
str1:       .string "["
str2:       .string ","
str3:       .string "]\n"
str4:       .string "Input is out of range!\n"

# input limit is 0~33, rowIndex is the input number
# Use stack to store result array and a temporary array
# the largest case of the array is 34 cells
# Because of the size of int is 4 bytes, the array's size is 34*4 = 136 bytes

# s0: input limit
# s1: address of result array in the stack
# s2: address of temporary array in the stack
# s3: rowIndex
# s4: outerLoop i
# s5: innerLoop j
            .text
main:
            addi sp, sp, -272       # initialize the space of the two arrays
            addi s1, sp, 136        # address of result array
            add  s2, sp, zero       # address of temporary array
            addi s3, zero, 5        # rowIndex = 5, 
            li   s0, 33				# input limit is 33

            blt  s3, zero, error    # if ( rowIndex < 0 ) goto error
            bgt  s3, s0, error		# if ( rowIndex > 33 ) goto error
			
            add  t0, zero, zero     # t0 = 0
            beq  s3, t0, input0     # if ( rowIndex == 0 ) goto input0

            addi t0, zero, 1        # t0 = 1
            beq  s3, t0, input1     # if ( rowIndex == 1 ) goto input1

            j    other              # rowIndex > 1
input0:
            addi t0, zero, 1        # t0 = 1
            sw   t0, 0(s1)          # result array = {1}
            j    printArr
input1:
            addi t0, zero, 1        # t0 = 1
            sw   t0, 0(s1)          # result array = {1}
            sw   t0, 4(s1)          # result array = {1,1}
            j    printArr
other:
            addi t0, zero, 1        # t0 = 1
            sw   t0, 0(s1)          # result array = {1}
            sw   t0, 4(s1)          # result array = {1,1}

            li   s4, 2              # s4 = i, initialize to 2
outerLoop:
            bgt  s4, s3, printArr   # if ( i <= rowIndex ) then loop, else goto printArr

            sw   t0, 0(s2)          # temporary array = {1}
            add  t1, zero, t0       # t1 is index of temporary array start from 1
            add  s5, zero, t0       # s5 = j, initialize to 1
innerLoop:  
            bge  s5, s4, outerIncre # if ( j < i ) then loop, else goto outerIncre
            slli t2, t1, 2          # t2 is the offset to access temporary array
            add  t2, t2, s2         # t2 is the address of temp[j]

            addi t3, s5, -1         # t3 = j - 1
            slli t3, t3, 2          # t3 is the offset 
            add  t3, t3, s1         # t3 is the address of result[j - 1]
            lw   t3, 0(t3)          # t3 = result[j - 1]

            add  t4, s5, zero       # t4 = j
            slli t4, t4, 2          # t4 is the offset
            add  t4, t4, s1         # t4 is the address of result[j]
            lw   t4, 0(t4)          # t4 = result[j]

            add  t3, t3, t4         # t3 = result[j - 1] + result[j]
            sw   t3, 0(t2)          # temp[j] = result[j - 1] + result[j]

            addi t1, t1, 1          # t1 = t1 + 1, t1 is index of temporary array
            addi s5, s5, 1          # j = j + 1
            j    innerLoop          # goto innerLoop
outerIncre:
            add  t2, s4, zero       # t2 = i
            slli t2, t2, 2          # t2 is the offset
            add  t2, t2, s2         # t2 is the address of temp[i]
            sw   t0, 0(t2)          # temp[i] = 1

            add  t2, s1, zero       # exchange the addresses of 
            add  s1, s2, zero       # result array and temporary array
            add  s2, t2, zero

            addi s4, s4, 1          # i = i + 1
            j    outerLoop          # goto outerLoop
			
printArr:
            add  t0, zero, zero     # k = 0, index of print loop
            la   a0, str1           # load label str1, which is "["
            li   a7, 4              # a7 = 4, which means ecall will print a string
            ecall

            slli t1, t0, 2          # t1 is the offset
            add  t1, t1, s1         # t1 is the address of result[0]
            lw   t1, 0(t1)          # t1 = result[0]

            add  a0, t1, zero       # a0 = result[0]
            li   a7, 1              # a7 = 1, which means ecall will print a integer
            ecall

            addi t0, t0, 1          # k = 1
printLoop:
            bgt  t0, s3, printStr3  # if ( k <= rowIndex ) then loop, else goto printStr3

            la   a0, str2           # load label str2, which is ","
            li   a7, 4              # a7 = 4, which means ecall will print a string
            ecall

            slli t1, t0, 2          # t1 is the offset
            add  t1, t1, s1         # t1 is the address of result[k]
            lw   t1, 0(t1)          # t1 = result[k]

            add  a0, t1, zero       # a0 = result[k]
            li   a7, 1              # a7 = 1, which means ecall will print a integer
            ecall

            addi t0, t0, 1          # k = k + 1
            j    printLoop
printStr3:
            la   a0, str3           # load label str3, which is "]\n"
            li   a7, 4              # a7 = 4, which means ecall will print a string
            ecall

            j    exit               # goto exit
error:
            la   a0, str4           # load label str4, which is the error message
            li   a7, 4              # a7 = 4, which means ecall will print a string
            ecall
exit:		
            addi sp, sp, 272        # release stack space
