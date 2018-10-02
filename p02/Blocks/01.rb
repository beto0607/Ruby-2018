
def da_nil? &block
  (not block_given?) || (block.call() == nil) 
end


p da_nil? {  }
p (da_nil? do
  "asdf"
end)
