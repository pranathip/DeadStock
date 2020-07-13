
import codecs
import requests
import json
import time
import os
import random

def reformat():
	with open("retro-jordans.json") as file:
		DATA = json.load(file)
		newData = []

		for k,v in DATA.items():
			v["name"] = k
			newData.append(v)

	with open("retro-jordans-reformatted.json", "w") as f:
		json.dump(newData, f, indent=4)
		f.close()

if __name__ == "__main__":
	reformat()


