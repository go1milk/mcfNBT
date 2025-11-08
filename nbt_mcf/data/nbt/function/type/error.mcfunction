$data modify storage nbt:type error_msg set from storage nbt:type/msg error[$(i)]

execute \
    if data storage nbt:type/config {"채팅창 에러 메세지 표시": true} \
    run tellraw @a {"storage":"nbt:type","nbt":"error_msg","interpret":true}
execute \
    unless data storage nbt:type/config "에러 메시지 저장"{"count": 0} \
    run function nbt:type/error_macro with storage nbt:type/config "에러 메시지 저장"

data remove storage nbt:type data[-1]
return run data get storage nbt:type/msg type[{name:Error}].id
