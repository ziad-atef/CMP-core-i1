import json
class Assembler:
    def __init__(self, input_path = "code.txt", output_path = "output.text", mode = "memory", instance = "/ram/ram") :

        # Setting the Commands into map to use them
        self.commands = {
        "ADD" : "0000001", "INC" : "0000011", "SUB" : "0001001",
        "AND" : "0001101", "NOT" : "0010001", "MOV" : "0010101", "IN" : "0011000",
        "OUT" : "0011001", "IADD" : "0100000", "LDM" : "0110101", "LDD" : "0100010", "STD" : "0100011",
        "JZ" : "1010100", "JN" : "1010101", "JC" : "1010110", "JMP" : "1010111",
        "NOP" : "1101000", "HLT" : "1100001", "SETC" : "1100010", "PUSH" : "1110010",
        "POP" : "1110101", "CALL" : "1111010", "RET" : "1111100", "INT" : "1111110", "RTI" : "1111100"
        }

        self.mode = mode
        self.instance = instance

        self.integrate(input_path, output_path)
    
    def seperate_instruction(self, command : str):
        '''
        This Function is used to seperate the instruction into Command and Operands
        Ex: MOV 000, 001
        NOTE: Seperation can be either by Space, or by Comma 

        Return: Command as splitted to list
        '''
        command_splitted : list = command.replace(',', ' ').split() # list of strings
        command_splitted[0] = self.commands[command_splitted[0].upper()]
        return command_splitted
    
    def generate_binary(self, command_as_list : list):
        operand = command_as_list[0]

        if operand in [self.commands['AND'], self.commands['SUB'], self.commands['ADD']]:
            return "".join(command_as_list) + " \n"
        
        elif operand in [self.commands['INC'], self.commands['NOT'], self.commands['MOV']]:
            return "".join(command_as_list) + "000" + " \n"
        
        elif operand in [self.commands["JZ"], self.commands["JN"], self.commands["JC"], self.commands["JMP"], self.commands["OUT"], self.commands["PUSH"], self.commands["CALL"]]:
            return command_as_list[0] + "000" + command_as_list[1] + "000" + " \n"
        
        elif operand in [self.commands["NOP"], self.commands["HLT"], self.commands["SETC"], self.commands["RET"], self.commands["RTI"]]:
            return "".join(command_as_list) + "000000000" + " \n"
        
        elif operand in [self.commands['POP'], self.commands['INT'], self.commands['IN']]:
            return "".join(command_as_list) + "000000" + " \n"
        
        elif operand in [self.commands["IADD"], self.commands["LDD"]]:
            return command_as_list[0] + command_as_list[1] + command_as_list[2] + "000" + command_as_list[3]
        
        elif operand == self.commands["LDM"] : 
            return command_as_list[0] + command_as_list[1] + "000" + "000" + command_as_list[2] 
        
        elif operand == self.commands["STD"] : 
            return command_as_list[0] + "000" + command_as_list[1] + command_as_list[2] + command_as_list[3]
        
        return "xxxxxxxxxxxxxxxx" + " \n"
    
    def read_code_file(self, path):
        file = open(path, 'r')

        instructions = [line for line in file]

        file.close()

        return instructions

    def assemble(self, output_path, binary_instructions : list):

        file = open(output_path, 'w')

        if self.mode == 'memory' :
            file.write("// memory data file (do not edit the following line - required for mem load use) \n")
            file.write(f"// instance={self.instance} \n")
            file.write("// format=mti addressradix=d dataradix=b version=1.0 wordsperline=1 \n")
        
        for index, ins in enumerate(binary_instructions):
            if self.mode == 'memory':
                file.write(f"{index}: ")

            file.write(ins)
        file.close()
    
    def integrate(self, input_path, output_path):
        
        # Read Instructions:
        instructions = self.read_code_file(input_path)

        binary_instructions = []

        for instruction in instructions:
            seperated_instruction = self.seperate_instruction(instruction)
            binary_instruction = self.generate_binary(seperated_instruction)
            if len(binary_instruction) > 20:
                binary_instructions.append(binary_instruction[0:16] + "\n")
                binary_instructions.append(binary_instruction[16:32] + "\n")
            else:
                binary_instructions.append(binary_instruction)
        
        self.assemble(output_path, binary_instructions)
        

        
if __name__ == '__main__' : 
    file = open('configurations.json')

    configurations = json.load(file)
    
    assembler = Assembler(configurations["input_path"], configurations["output_path"], configurations["mode"], configurations["instance"])