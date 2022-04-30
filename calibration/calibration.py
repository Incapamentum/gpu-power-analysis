"""
    Access the files generated in the output/ directory of the calibration
"""

import os
import pickle

FILE_PATH = "./instruction_microbenchmarks/output/"
OUTPUT_FILE = "instruction_energy.pickle"
NUM_INSTRUCTIONS = 20 * (10 ** 6)

i_energy = {}

# Collecting the energy of each instruction
for filename in os.listdir(FILE_PATH):

    i_name = filename

    with open(os.path.join(FILE_PATH, filename), "r") as f:
        
        for line in f.readlines():
            
            if ("Energy" in line):
                energy = line[7:-3]
                i_energy[i_name] = float(energy)

# Calculating actual energy
e_overhead = i_energy.pop("Ovhd")

for key in i_energy.keys():
    e_total = i_energy[key]
    e_instruction = e_total - e_overhead
    e_instruction = e_instruction / NUM_INSTRUCTIONS
    i_energy[key] = e_instruction

with open(OUTPUT_FILE, "wb") as p:
    pickle.dump(i_energy, p)