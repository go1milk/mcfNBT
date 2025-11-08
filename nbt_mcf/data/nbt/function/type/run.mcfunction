# custom = ?
execute unless data storage nbt:type data[1] store result storage nbt:type tmp.return int 1 \
    run function type/custom
execute \
    if data storage nbt:type tmp.return \
    unless data storage nbt:type tmp{return: 0} run return \
    run data get storage nbt:type tmp.return

# None = 0
execute unless data storage nbt:type data[-1].current run return run data get storage nbt:type/msg type[{name:None}].id

# Compound = 10
execute if data storage nbt:type data[-1].current{} run return run data get storage nbt:type/msg type[{name:Compound}].id

# List, Array = 11..14
data modify storage nbt:type tmp.copy set from storage nbt:type data[-1].current
execute store success storage nbt:type tmp.success int 1 run \
    data modify storage nbt:type tmp.copy append value 0b
execute if data storage nbt:type tmp{success:1} run return run function nbt:type/list

# String = 7
data modify storage nbt:type tmp.copy set from storage nbt:type data[-1].current
execute store success storage nbt:type tmp.success int 1 run \
    data modify storage nbt:type tmp.copy set string storage nbt:type tmp.copy
execute if data storage nbt:type tmp{success:0} run return run data get storage nbt:type/msg type[{name:String}].id

# Float = 5..6
data modify storage nbt:type tmp.suf set string storage nbt:type data[-1].current -1
execute if data storage nbt:type tmp{suf:'f'} run return run data get storage nbt:type/msg type[{name:Float}].id
execute if data storage nbt:type tmp{suf:'d'} run return run data get storage nbt:type/msg type[{name:Double}].id

# Integer = 2..5
data modify storage nbt:type buffer.ByteArray append from storage nbt:type data[-1].current
execute store success storage nbt:type tmp.success int 1 run \
    data modify storage nbt:type buffer.ByteArray[0] set from storage nbt:type data[-1].current
execute if data storage nbt:type tmp{success:0} run return run data get storage nbt:type/msg type[{name:Byte}].id

data modify storage nbt:type buffer.IntArray append from storage nbt:type data[-1].current
execute store success storage nbt:type tmp.success int 1 run \
    data modify storage nbt:type buffer.IntArray[0] set from storage nbt:type data[-1].current
execute if data storage nbt:type tmp{success:0} run return run data get storage nbt:type/msg type[{name:Int}].id

data modify storage nbt:type buffer.LongArray append from storage nbt:type data[-1].current
execute store success storage nbt:type tmp.success int 1 run \
    data modify storage nbt:type buffer.LongArray[0] set from storage nbt:type data[-1].current
execute if data storage nbt:type tmp{success:0} run return run data get storage nbt:type/msg type[{name:Long}].id

return run data get storage nbt:type/msg type[{name:Short}].id
