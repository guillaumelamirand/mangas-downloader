class Mangas(object):	
	_items = None

	@staticmethod
	def load_items(config):		
		Mangas._items = {manga.id: manga for manga in config['mangas']}

	@staticmethod
	def get_items():
		return Mangas._items.iteritems()

	@staticmethod
	def get_all():
		return Mangas._items.values()

	@staticmethod
	def get(id):
		return Mangas._items[id]
		
class Manga(object):

	def __init__(self, id, serie, serie_index_increment, serie_sub_index_max, source, chapiter_ignored):
		self.id = id
		self.serie = serie
		self.serie_index_increment = serie_index_increment
		self.serie_sub_index_max = serie_sub_index_max
		self.source = source
		self.chapiter_ignored = chapiter_ignored

	def __repr__(self):
		return "%s(id=%r, serie=%r, serie_index_increment=%r, serie_sub_index_max=%r, source=%r, chapiter_ignored=%r)" % (self.__class__.__name__, self.id, self.serie, self.serie_index_increment, self.serie_sub_index_max, self.source, self.chapiter_ignored)

