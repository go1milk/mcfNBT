#tellraw @s {"storage":"nbt:type/msg","nbt":"error[]","interpret":true,"separator":"\n\n"}

data remove storage nbt:type/msg msg

# function
data modify storage nbt:type/msg msg.function set value { \
    "hover_event": { \
        "action": "show_text", "value": [ \
            {"text": "function type {\"s\": [\n  <source>, <path>, (block | entity | storage)\n]}"} \
        ] \
    }, \
    "text": "minecraft:type" \
}

# datapack
data modify storage nbt:type/msg msg.datapack set value [ \
    { \
        "text": "[", \
        "color": "green", \
        "hover_event": { \
            "action": "show_text", \
            "value": [ \
                {"text": "nbt_mcf\nnbt 타입 검사 데이터팩"} \
            ] \
        } \
    }, \
    { \
        "text": "file/nbt_mcf (세계)", \
        "color": "gray", \
        "hover_event": { \
            "action": "show_text", \
            "value": [ \
                {"text":"nbt_mcf\nnbt 타입 검사 데이터팩"} \
            ] \
        } \
    }, \
    { \
        "text": "]", \
        "color": "green", \
        "hover_event": { \
            "action": "show_text", \
            "value": [ \
                {"text":"nbt_mcf\nnbt 타입 검사 데이터팩"} \
            ] \
        } \
    } \
]

data modify storage nbt:type/msg error set value []

data modify storage nbt:type/msg error append value [ \
    {"color": "red", "text" :""}, \
    {"storage": "nbt:type/msg", "nbt": "msg.function", "interpret": true}, \
    " 함수를 시작할 수 없습니다: ", \
    {"storage": "nbt:type/msg", "nbt": "msg.function", "interpret": true}, \
    " 함수에 s 인수가 누락되었습니다.", \
    {"color": "white", "text": "\n해당 오류 메시지는 "}, \
    {"storage": "nbt:type/msg", "nbt": "msg.datapack", "interpret": true}, \
    {"color": "white", "text": "에 의해 생성되었습니다"} \
]

data modify storage nbt:type/msg error append value [ \
    {"color": "red", "text" :""}, \
    {"storage": "nbt:type/msg", "nbt": "msg.function", "interpret": true}, \
    " 함수를 시작할 수 없습니다: ", \
    {"storage": "nbt:type/msg", "nbt": "msg.function", "interpret": true}, \
    " 함수에 사용되지 않는 인수가 존재합니다.", \
    {"color": "white", "text": "\n해당 오류 메시지는 "}, \
    {"storage": "nbt:type/msg", "nbt": "msg.datapack", "interpret": true}, \
    {"color": "white", "text": "에 의해 생성되었습니다"} \
]

data modify storage nbt:type/msg error append value [ \
    {"color": "red", "text" :""}, \
    {"storage": "nbt:type/msg", "nbt": "msg.function", "interpret": true}, \
    " 함수를 시작할 수 없습니다: ", \
    {"storage": "nbt:type/msg", "nbt": "msg.function", "interpret": true}, \
    " 함수에 지원하지 않는 nbt_type이 존재합니다.", \
    {"color": "white", "text": "\n해당 오류 메시지는 "}, \
    {"storage": "nbt:type/msg", "nbt": "msg.datapack", "interpret": true}, \
    {"color": "white", "text": "에 의해 생성되었습니다"} \
]

# 타입표 매핑
data modify storage nbt:type/msg type set value [ \
    {id: -1, name: Error}, \
    {id: 0, name: None}, \
    {id: 1, name: Byte}, \
    {id: 2, name: Short}, \
    {id: 3, name: Int}, \
    {id: 4, name: Long}, \
    {id: 5, name: Float}, \
    {id: 6, name: Double}, \
    {id: 7, name: String}, \
    {id: 10, name: Compound}, \
    {id: 11, name: List}, \
    {id: 12, name: ByteArray}, \
    {id: 13, name: IntArray}, \
    {id: 14, name: LongArray} \
]
