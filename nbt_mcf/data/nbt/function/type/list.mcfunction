# nbt/.../type/list.mcfunction
# init
data remove storage nbt:type tmp.copy[]

# ByteArray
execute if data storage nbt:type {tmp:{copy:[B;]}} run return 11

# IntArray
execute if data storage nbt:type {tmp:{copy:[I;]}} run return 12

# LongArray
execute if data storage nbt:type {tmp:{copy:[L;]}} run return 13

# List
return 10
