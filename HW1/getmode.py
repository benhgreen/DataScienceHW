# I did this because libreoffice kept freezing, pls don't judge

#in retrospect I could have sorted and just selected each value rance and looked at the beginning and ending cell values :(

import csv

def getMode(csv_file, column):
	# open file
	with open(csv_file, 'rb') as csvfile:
		# init database and dict to hold count of each value
		database = csv.reader(csvfile)
		count = {}

		# iterate through column and record each value
		for row in database:
			if row[column] in count:
				count[row[column]] = count[row[column]] + 1
			else:
				count[row[column]] = 1

		# print each key/value in dict
		for key in count:
			print "%s: %d" % (key, count[key])
		
		# print mode
		print "Most common value is %s" % max(count, key=count.get)

if __name__ == '__main__':
	getMode('laptops.csv', 0)


# IBM: 72
# producer: 1
# Alienware: 134
# GigaFast: 1
# NEC: 6
# Aspire: 32
# MSI: 193
# CTL: 1
# Twinhead: 1
# Compaq: 383
# Satellite: 6
# ViewSonic: 4
# NB: 1
# Nokia: 8
# Precision: 1
# unknown_seller: 68
# Toshiba: 3400
# XPS: 1
# Hannspree: 3
# Everex: 1
# HP: 4359
# Lenovo: 1056
# Pavilion: 15
# Intel: 6
# Samsung: 663
# JVC: 36
# Zotac: 1
# DELL: 1627
# Gigabyte: 4
# Fujitsu: 55
# Sony: 1714
# Asus: 4380
# Velocity: 1
# CyberPower: 4
# Steel Sound: 4
# Rocketfish: 5
# Apple: 4480
# CellularFactory: 1
# Brightpoint: 7
# eMachines: 182
# Acer: 1472
# Gateway: 328
# Panasonic: 19
# Most common value is Apple
# [Finished in 0.0s]