
from time import time, sleep





# class timestampClass():
# 	def __init__(self):



# t = float(time())
# for h in range(100*24 ):
# 	print(f'hour +{h}')
# 	print(t)
# 	truncated = int(t*0.00001)

# 	print(truncated)
# 	print(base36encode(truncated))
# 	print()

# 	t += 60*60
# 	sleep(0.01)


class densestamp():
	def __init__(self, order=4):
		'''defines the truncation order upon initialization. 4 removes the last 4 digits from unix time. This time stamp is around 3 hours long.'''
		self.order = order

		seconds = 10**order
		minutes = 10**order / 60 
		hours   = 10**order / 60 / 60
		days    = 10**order / 60 / 60 / 24

		print(f"seconds: {round(seconds,2)}")
		print(f"minutes: {round(minutes,2)}")
		print(f"hours:   {round(hours,2)}")
		print(f"days:    {round(days,2)}")

	def __str__(self):
		return self.make()

	def base36encode(self, number, alphabet='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'):
		"""Converts an integer to a base36 string."""
		if not isinstance(number, int):
			raise TypeError('number must be an integer')
	
		base36 = ''
		sign = ''
	
		if number < 0:
			sign = '-'
			number = -number
	
		if 0 <= number < len(alphabet):
			return sign + alphabet[number]
	
		while number != 0:
			number, i = divmod(number, len(alphabet))
			base36 = alphabet[i] + base36
	
		return sign + base36

	def make(self):
		t = float(time())
		truncated = int(t/10**self.order)
		return self.base36encode(truncated)






