import math

points = {
	'a': (1,6),
	'b': (3,7),
	'c': (4,3),
	'd': (7,7),
	'e': (8,2),
	'f': (9,5)
}

def sum_squared(inputpt, cluster):
	total = 0;
	for point in cluster:
		dist = math.hypot(inputpt[0]-point[0], inputpt[1]-point[1])
		total = total + dist**2
	return total


if __name__ == '__main__':
	
	cluster = [points['e'], points['f'], points['c'], points['d']]

	target = 1000
	for point in cluster:
		if sum_squared(point, cluster) < target:
			print point
			target = sum_squared(point, cluster)

	print target