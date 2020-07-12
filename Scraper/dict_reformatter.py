import os
import json
import random

with open('retro-jordans.json') as file:
	DATA = json.load(file)
	newData = dict()

def reformat():
	for key,value in DATA.items():
		#print(value["image"])
		newData[value["image"]] = value

		for k,v in newData.items():
			v["image"] = key

	with open('reformatted.json', 'w') as f:
            json.dump(newData, f, indent=4)
            f.close()


if __name__ == "__main__":
    reformat()
