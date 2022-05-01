import pickle
import sys

# Using this as default as this is where the files are located at
BENCHMARK_PATH = "../program_benchmarks/"

# Path to the pickled calibration energy
CALIBRATION_PATH = "../calibration/"
ENERGY_FILE = CALIBRATION_PATH + "instruction_energy.pickle"

# The argument must be the name of the program to profile
if (len(sys.argv) != 2):
    print("Insufficient arguments!")
    sys.exit(-1)

# Grabbing the calibrated energy results
with open(ENERGY_FILE, "rb") as f:
    energy_data = pickle.load(f)

print(energy_data)


b_name = BENCHMARK_PATH + sys.argv[1] + "/"
ptx_file = b_name + "ptx/a.1.sm_75.ptx"

num_inst = [0, 0, 0]


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

print(total_energy)