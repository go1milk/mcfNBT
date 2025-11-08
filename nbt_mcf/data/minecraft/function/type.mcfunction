# function type {s:[<target>, <targetPath>, <target=storage>]}
# target ::= block | entity | storage

# init
# Error = -1
data remove storage nbt:type tmp
data remove storage nbt:type error_msg
data modify storage nbt:type data append value {}

data modify storage nbt:type buffer.ByteArray set value [B;]
data modify storage nbt:type buffer.IntArray set value [I;]
data modify storage nbt:type buffer.LongArray set value [L;]

$data modify storage nbt:type tmp.raw set value $(s)


data modify storage nbt:type tmp.nbt_type set from storage nbt:type tmp.raw[2]
execute \
    unless data storage nbt:type tmp.raw[1] \
    run return \
        run function nbt:type/error {i: 0}

execute \
    if data storage nbt:type tmp.raw[3] \
    run return \
        run function nbt:type/error {i: 1}

execute \
    unless data storage nbt:type tmp{nbt_type:"block"} \
    unless data storage nbt:type tmp{nbt_type:"entity"} \
    unless data storage nbt:type tmp{nbt_type:"storage"} \
    if data storage nbt:type tmp.raw[2] \
    run return \
        run function nbt:type/error {i: 2}

#
data modify storage nbt:type data[-1].target set from storage nbt:type tmp.raw[0]
data modify storage nbt:type data[-1].path set from storage nbt:type tmp.raw[1]
data modify storage nbt:type data[-1].nbt_type set value "storage"
data modify storage nbt:type data[-1].nbt_type set from storage nbt:type tmp.raw[2]

function nbt:type/init/macro with storage nbt:type data[-1]

execute store result storage nbt:type tmp.return int 1 run function nbt:type/run

data remove storage nbt:type data[-1]

return run data get storage nbt:type tmp.return
