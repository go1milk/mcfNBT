# nbt_mcf (DataPack) JE 1.21.10

## 목차
| ╲&nbsp; | Element |
|---:|---|
| 1. | [목차](#목차)
| 2. | [왜 만들었나요?](#왜-만들었나요) |
| 3. | [적용되었는지는 어떻게 확인하나요?](#적용되었는지는-어떻게-확인하나요) |
| 4. | [무슨 기능이 있나요](#무슨-기능이-있나요) |
| 4-1. | [Type 함수](#1-type) |

## 왜 만들었나요?
데이터팩 **nbt_mcf**는 마인크래프트의 기본적인 nbt를 관리하기 위해 만들어진 프로젝트입니다.

## 적용되었는지는 어떻게 확인하나요?
nbt_mcf가 제대로 작동하는지 확인하려면 다음 명령어를 실행해보세요:
```
/datapack list enabled
```
데이터팩이 적용되었다면 출력 메세지는 다음과 같습니다:
```
켜진 데이터팩이 n개 있습니다: [vanilla (내장)] ... [file/nbt_mcf (세계)]
```

## 무슨 기능이 있나요?
## 1. type
type 함수는 nbt의 타입을 추론하여 매핑된 숫자를 반환합니다.

## 어떻게 사용하나요?
type 함수의 문법은 다음과 같습니다:
```
function type {s:[<target>, <targetPath>, [<nbt_type>]]}
function minecraft:type {s:[<target>, <targetPath>, [<nbt_type>]]}
```
**<nbt_type>은 생략 시 "storage"로 적용됩니다.**

## 예시
명령어를 실행한 대상의 Health 타입을 반환하는 예시 명령어:
```
/function minecraft:type {s:['@s', Health, entity]}
```
출력:
```
minecraft:type 함수를 실행합니다
minecraft:type 함수가 5을(를) 반환했습니다
```
반환된 수는 아래 명령어를 이용해서 저장이 가능합니다.
```
execute store result storage test testPath int 1 run function minecraft:type {s:['@s', Health, entity]}
```

## 매핑된 숫자는 어떻게 얻나요?
매핑된 숫자를 얻으려면 다음 명령어를 실행하면 됩니다:
```
data get storage nbt:type/msg type
```
혹은, 다음 명령어를 실행하여 특정 타입의 id를 찾을 수도 있습니다.
```
data get storage nbt:type/msg type[{name:Error}].id
```

## custom

**주의! 이 기능은 높은 숙련도를 요구합니다.**

type/custom 함수의 경로는 다음과 같습니다:
```
nbt_mcf/data/minecraft/function/type/custom.mcfunction
```

type/custom 함수는 기존 마인크래프트가 제공하는 NBT 타입과 별도로, 사용자가 정의한 기준에 따라 값의 구조나 형태를 추적하고 새로운 타입 값을 반환합니다.

custom 타입이 `return fail`이나 `return 0`을 반환하지 않는다면, 기존의 NBT 타입의 반환값을 무시합니다.

type/custom 함수 안에서 호출된 type 함수는 더 이상 type/custom 함수를 호출하지 않습니다.

이 방식은 다음과 같은 상황에서 유용합니다:

- 단순한 NBT 타입이 아니라 데이터 의미 기반 분류가 필요할 때

- 특정 구조의 데이터(예: 객체 형태, 시스템 엔티티 상태)를 식별하거나 라우팅할 때

- 대규모 시스템에서 상태 머신 또는 커스텀 객체 구조를 구현할 때

다음은 type/custom 함수 안에 넣을 수 있는 간단한 예제입니다.

### 1. 현재 값 얻기
```
data get storage nbt:type data[0].current
```

### 2. 기존의 타입을 다른 값을 반환하게 바꾸기
해당 코드는 현재 값의 타입을 test testPath 스토리지에 저장하고, 저장된 값이 30이라면 100을 반환합니다.
```
execute store result storage test testPath int 1 run function type {s:['nbt:type', 'data[0].current']}
execute if data storage test {testPath: 30} run return 100
```

### 3. 원하는 포맷 검사하기
만약 당신이 {"storage":"","nbt":""} 형태의 값을 100으로 반환하고 싶다면, type/custom 함수에 아래 코드를 사용하면 됩니다:
```
execute if data storage nbt:type data[0].current.storage if data storage nbt:type data[0].current.nbt run return 100
```
더 엄격한 검사를 원한다면, `function type {s:['nbt:type', 'data[0].current']}`으로 Compound임을 검사하고, `data get storage nbt:type data[0].current`의 결과를 저장하여 개수를 검사할 수도 있습니다.

### 새로운 타입을 생성할 때 도움을 줄 수 있는 정보
당신이 새로운 포맷을 만들어 새 타입에 반영하려면 단순히 return <value>를 할 수도 있지만, nbt:type/msg 함수에 있는 매핑에 값을 추가할 수도 있습니다. 이는 복잡한 데이터 타입을 유연하게 관리할 수 있게 도와줄 수 있습니다.

타입표 매핑 부분에 새로운 타입을 추가해보세요.
```
# 타입표 매핑
data modify storage nbt:type/msg type set value [ \
    {id: -1, name: Error}, \
    ...
    {id:100, name: CustomType} \
]
```
**새로운 값을 추가하려면 ","와 "\\"를 추가해야 됩니다.**

type/custom 함수 안에 return <value> 대신, 아래 명령어로 유연한 관리도 가능합니다.
```
return run data get storage nbt:type/msg type[{name:CustomType}].id
```
