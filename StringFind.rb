class String

	def find(instr, start=0)
		found = self.index(instr, start)
		return -1 if found == nil
		return found + instr.length()
	end

end
