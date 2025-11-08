$execute \
    if data storage $(storage) $(nbt)[$(count)] \
    run data remove storage $(storage) $(nbt)[0]

$execute \
    unless data storage $(storage) $(nbt)[$(count)] \
    run data modify storage $(storage) $(nbt) append from storage nbt:type error_msg
