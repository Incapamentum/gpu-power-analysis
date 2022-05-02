import pickle
import re
import sys

# Using this as default as this is where the files are located at
BENCHMARK_PATH = "./program_benchmarks/"

# Path to the pickled calibration energy
CALIBRATION_PATH = "./calibration/"
ENERGY_FILE = CALIBRATION_PATH + "instruction_energy.pickle"

# The argument must be the name of the program to profile
if (len(sys.argv) != 2):
    print("Insufficient arguments!")
    sys.exit(-1)

# Grabbing the calibrated energy results
with open(ENERGY_FILE, "rb") as f:
    energy_data = pickle.load(f)

b_name = BENCHMARK_PATH + sys.argv[1] + "/"
ptx_file = b_name + "ptx/a.1.sm_75.ptx"

num_inst = [0, 0, 0]

# Needed for overall parsing
params = []
registers = {}
branch_names = []
pred_instructions = []

f_ptx = open(ptx_file, "r")

# Obtaining the params
for line in f_ptx.readlines():

    if (".param ." in line):

        l_split = line.split()
        l_split[-1] = re.sub('[,\n]', '', l_split[-1])
        params.append(l_split[-1])

# Resetting file pointer
f_ptx.seek(0)

# Obtaining basic registers
for line in f_ptx.readlines():

    for p in params:

        if ((p in line) and ("ld" in line)):
            l_split = line.split()
            l_split[-1] = re.sub('[\[\]]', '', l_split[-1])
            registers[l_split[1]] = l_split[-1]

regs = registers.keys()

# Resetting
f_ptx.seek(0)

# Obtaining branch names
for line in f_ptx.readlines():

    if ("$L_" in line):

        if (len(line.split()) == 1):
            line = re.sub('[:\n]', '', line)
            branch_names.append(line)

# Resetting
f_ptx.seek(0)

# Collecting setp instructions
for line in f_ptx.readlines():

    if ("setp." in line):
        line = re.sub('[\n]', '', line)
        pred_instructions.append(line)

# Resetting
f_ptx.seek(0)

# This is not a completely accurate count of the instructions
with open(ptx_file, "r") as f:

    for line in f.readlines():

        # Adding instruction counts
        if ("add" in line):
            num_inst[0] += 1
        elif ("mul" in line):
            num_inst[1] += 1
        elif ("div" in line):
            num_inst[2] += 1

total_energy = energy_data["Add"] * num_inst[0]
total_energy += energy_data["Mul"] * num_inst[1]
total_energy += energy_data["Div"] * num_inst[2]

print(f'Total energy: {total_energy} J')

f_ptx.close()