基本数据类型
=================

类型与方法
----------------

str
^^^^^^^

  - 索引、切片：[ind]；[first:last] 获取区间 [first, last) 内的元素。

  - 长度：len

  - 查找：若字符/序列不在字符串内，index 抛出异常 ``ValueError`` ；find 返回 -1。

  - 判断字符串内容：字母，isalpha()；数字，isdigit()；数字或字母，isalnum()；大小写，isupper()，islower()。

  - 大小写转换：capitalize()、lower()、upper()。

  - 获取字符 ASCII 码：ord(c)

  - 根据 ASCII 码转换为字符：chr(n)，ASCII 码在 0 到 255 之间。

  - 判断开头结尾：startswith、endswith。

  - 连接：join，将字符串、元组、列表中的元素以指定的字符（分隔符）连接生成一个新的字符串。

  - 分割：split、partition。 **如果想把字符串分割成独立的字符，用 list(string)。**

  - 替代：replace

  - 清除空白: strip、lstrip、rstrip

  .. code-block:: python
    :linenos:

    >>> s = "abcde"
    >>> "-".join(s)
    a-b-c-d-e
    >>> s = ['abc', 'def', 'ghi']
    >>> "-".join(s)
    abc_def_ghi
    >>> s
    ['abc', 'def', 'ghi']

    >>> s = "a-b-c-d-e"
    >>> s.partion('-') ## 只能分割为3部分
    ('a', '-', 'b-c-d-e')
    >>> s.split('-')
    ['a', 'b', 'c', 'd', 'e']
    >>> s
    "a-b-c-d-e"

  .. warning::

    **str** 是不可变对象，其所有方法都 **不改变对象本身** ，而是返回所创建的新对象。

tuple
^^^^^^^^^^^^^^

  - 索引、切片：[ind]；[first:last] 获取区间 [first, last) 内的元素。
  
  - 元组的元素不可改变，类似于常量类型。

  - **collections.namedtuple** ：构造一个带字段名的元组，可以通过索引、切片或属性名称进行访问。::

      collections.namedtuple(typename, field_names, verbose=False, rename=False) 

  .. code-block:: python
    :linenos:

    >>> from collections import namedtuple
    >>> User = namedtuple('User', ['name', 'age', 'id']) ## 或 User = namedtuple('User', 'name age id')
    >>> user = User(name='tester', age='22', id='464643123') ## 或 user = User('tester', '22', '464643123')
    >>> user
    User(name='tester', age='22', id='464643123')
    >>> user._fields
    ('name', 'age', 'id')
    >>> user.name
    'tester'

    ## 使用 _replace 修改属性，返回新的对象
    >>> user._replace(age='12')
    User(name='tester', age='12', id='464643123')

    ## 使用 _asdict 将元组转换为有序字典
    >>> user._asdict()
    OrderedDict([('name', 'tester'), ('age', '22'), ('id', '464643123')])

    ## 使用 _make 用列表构造元组
    >>> user = User._make(['fong', 25, '000000000'])
    >>> user
    User(name='fong', age=25, id='000000000')
    >>> user[:2]
    ('fong', 25)



list
^^^^^^^^^^^^^^

  - 索引、切片：[ind]；[first:last] 获取区间 [first, last) 内的元素。

  - 统计元素出现的次数：count

  - 追加：append

  - 拓展：extend

  - 插入：insert

  - 弹出元素：pop，默认弹出列表末尾的元素

  - 清空：clear()

  - 移除/删除元素：remove，del （del可删除切片）

  - 排序：sort

  - 逆序：reverse

  .. code-block:: python
    :linenos:

    >>> a = [1,2,3]
    >>> a.append(4)
    >>> a
    [1, 2, 3, 4]
    >>> a.extend([10,20,30])
    >>> a
    [1, 2, 3, 4, 10, 20, 30]

    >>> a.insert(1, 5) ## 在第一个元素之后插入
    >>> a
    [1, 5, 2, 3, 4, 10, 20, 30]

    >>> a.remove(2)
    >>> a
    [1, 5, 3, 4, 10, 20, 30]
    >>> del a[3]
    >>> a
    [1, 5, 3, 10, 20, 30]

    >>> a.sort(reverse=True)
    >>> a
    [30, 20, 10, 5, 3, 1] ## 直接修改 a，无返回值。使用 sorted 返回排序后的副本。

    >>> a2 = a.pop(2)
    >>> a2
    10
    >>> a
    [30, 20, 5, 3, 1]

.. note::

  对于 ``切片（slice）`` 操作，下标越界 **不会** 报错，返回空。

  对于 ``索引（index）`` 操作，下标越界 **会** 报错。

  .. code-block:: text

      s[i:j]

      The slice of s from i to j is defined as the sequence of items with index k such that i <= k < j.

      If i or j is greater than len(s), use len(s).
      If i is omitted or None, use 0.
      If j is omitted or None, use len(s).
      If i is greater than or equal to j, the slice is empty.

  .. code-block:: text

      s[i:j:-1]

      - 当 i 省略，默认使用 len(s)。
      - 当 j 省略，输出 s[0:i+1] 的逆序。
      - 当 j = -1，默认使用 len(s)，会输出空列表。注意，这里不等同于 s[i::-1]。
      - s[::-1] 是 s 的逆序。

dict
^^^^^^^^^^^^^^

  - 获取：keys()，values()，items()。在 Python3 中返回的不再是列表，而是 dict_keys、dict_values、dict_items，需要手动转换为列表。

  - 清空：clear()

  - 删除：pop(key)，返回健对应的值，并删除键所对应的键值对。

  - 访问：get(key)，不存在时返回 None。

  - 更新：update(d)，把另一个字典 d 中的项添加到当前字典。

  - 浅复制：copy()

  .. code-block:: python
    :linenos:

    >>> info ={
    ...      "name":"Tom",
    ...       "age":25,
    ...       "sex":"man",
    ...      }
    >>> info.keys()
    ['age', 'name', 'sex']
    >>> info.values()
    [25, 'Tom', 'man']
    >>> info.items()
    [('age', 25), ('name', 'Tom'), ('sex', 'man')]

    >>> info.get(age)
    25
    >>> new = {"weight": 60}
    >>> info.update(new)
    >>> info
    {'age': 25, 'name': 'Tom', 'weight': 60, 'sex': 'man'}
    >>> info.clear()
    >>> info
    {}

  - **collections.OrderedDict** ：按关键字排序的字典。

  - **collections.defaultdict** ：defaultdict 类使用一种给定数据类型来初始化。当所访问的 key 不存在的时候，会实例化一个 value 作为默认值。因此，判断某个 key 是否存在，应使用 get(key)。

  .. code-block:: python
    :linenos:

    >>> from collections import defaultdict
    >>> dd = defaultdict(list) ## 使用 list 作为value type
    defaultdict(<type 'list'>, {})
    >>> dd['a']
    []
    >>> dd['b'].append("hello")
    defaultdict(<type 'list'>, {'a': [], 'b': ['hello']})

  .. warning::

    如果一个 defaultdict 必须包含给定的 key，则首先要 **显式** 地对所有的 key 进行访问和初始化。毕竟 defaultdict 只会为访问过的 key 关联一个默认值。

set
^^^^^^^^^^^^^^

  - 特征：无重复，无须，每个元素为不可变类型

  - 增加元素：单个元素，add；多个元素，update

  - 删除：删除元素不存在，remove 报错，discard 无反应。
  
  - 清空：clear()

  - 集合操作：\&，\|，\-，\^（交差补集，去除交集后剩下元素的并集），issubset 、isupperset。

  .. code-block:: python
    :linenos:

    >>> s1 = {'a', 'b', 'c'} ## 或者 s1 = set(['a', 'b', 'c'])
    >>> s1.update({'e','d'})
    >>> s1
    set(['a', 'c', 'b', 'e', 'd'])


深复制和浅复制
----------------

- **直接赋值** ：并没有拷贝对象，而是拷贝了对象的引用，因此原始对象或被赋值对象的改变，都会导致另一个对象被修改。

  .. code-block:: python
    :linenos:

    >>> alist = [1,2,3]
    >>> b = alist ## 引用
    >>> c = alist[:] ## 复制
    >>> alist.append(5)
    >>> alist
    [1, 2, 3, 5]
    >>> b
    [1, 2, 3, 5]
    >>> c
    [1, 2, 3]
    >>> b[0] = -1
    >>> a
    [-1, 2, 3, 5]
    >>> b
    [-1, 2, 3, 5]
    >>> c
    [1, 2, 3]

- **浅复制** ：只会复制父对象，而不会复制对象的内部的子对象。

  .. code-block:: python
    :linenos:

    >>> from copy import copy
    >>> alist = [1,2,3,['a','b']] ## ['a','b'] 是列表，是一个子对象
    >>> a_copy = copy(alist) ## dict类有copy()方法，e.g.，d.copy()
    >>> alist.append(5) ## 非子对象的修改
    >>> alist
    [1, 2, 3, ['a', 'b'], 5]
    >>> a_copy
    [1, 2, 3, ['a', 'b']]
    >>> a_copy[0] = -1
    >>> alist
    [1, 2, 3, ['a', 'b'], 5]
    >>> a_copy
    [-1, 2, 3, ['a', 'b']]

    >>> alist[3].append('c') ## 子对象的修改
    >>> alist
    [1, 2, 3, ['a', 'b', 'c'], 5]
    >>> a_copy
    [-1, 2, 3, ['a', 'b', 'c']]
    >>> a_copy[3].append('d')
    >>> alist
    [1, 2, 3, ['a', 'b', 'c', 'd'], 5]
    >>> a_copy
    [-1, 2, 3, ['a', 'b', 'c', 'd']]


- **深复制** ：复制对象及其子对象，原始对象的改变不会造成深复制里任何子元素的改变。

  .. code-block:: python
    :linenos:

    >>> from copy import deepcopy
    >>> alist = [1,2,3,['a','b']] ## ['a','b'] 是列表，是一个子对象
    >>> a_copy = deepcopy(alist)
    >>> alist[3].append('c') ## 子对象的修改
    >>> alist
    [1, 2, 3, ['a', 'b', 'c']]
    >>> a_copy
    [1, 2, 3, ['a', 'b']]
    >>> a_copy[3].append('d')
    >>> alist
    [1, 2, 3, ['a', 'b', 'c']]
    >>> a_copy
    [1, 2, 3, ['a', 'b', 'd']]


.. note::

  对于可变对象 **dict** 和 **list** 、 **set** ，需要暂存临时对象或者作为函数参数传递时，如果不希望对象被更改，都需要使用深复制。


再谈可变对象与不可变对象
----------------------------

第一章和第十五章提到可变对象与不可变对象。

**dict** 和 **set** 的底层实现都是 **哈希表** 。哈希要求key唯一，因此 **dict** 和 **set** 的key都要求是 **不可变对象** 。

.. code-block:: python
  :linenos:

  >>> x = 'abcd'
  >>> id(x)
  317860320L
  >>> x += 'efg'
  >>> id(x)
  317859200L
  >>> x = 1
  >>> id(x)
  31429240L
  >>> x += 2
  >>> id(x)
  31429192L
  ## x 的加法运算生成了一个新的对象，而不是对原对象的改变

  >>> a = [5, 3, 4, 3]
  >>> id(a)
  314009096L
  >>> b = [5, 3, 4, 3] ## b = a[:]
  >>> id(b)
  314011080L
  ## a 和 b 的 id 不同，尽管值相同
  >>> b.append(1)
  >>> b
  [5, 3, 4, 3, 1]
  >>> id(b)
  314011080L
  ## 改变 b，仍然是同一个对象，因此是可变对象

参考资料
------------

1. Python基本数据类型

  https://www.cnblogs.com/littlefivebolg/p/8982889.html

2. 切片python字符串时 为何不会引起下标越界?

  https://segmentfault.com/q/1010000011412371

3. python中defaultdict方法的使用

  https://www.cnblogs.com/dancesir/p/8142775.html

4. python的复制，深拷贝和浅拷贝的区别

  https://www.cnblogs.com/xueli/p/4952063.html

5. Python学习日记之字典深复制与浅复制

  https://www.cnblogs.com/mokero/p/6662202.html

6. Python namedtuple

  https://www.runoob.com/note/25726
