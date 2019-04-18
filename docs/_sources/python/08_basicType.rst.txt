基本数据类型
=================

类型与方法
----------------

- **str**

  - 索引、切片

  - 长度：len()

  - 查找：若字符/序列不在字符串内，index()报错 ValueError，find()返回-1。

  - 判断字符串内容：字母，isalpha()；数字，isdigit()；数字或字母，isalnum()。

  - 大小写转换：capitalize()、lower()、upper()。

  - 判断以什么开头结尾：startswith()、endswith()。

  - 连接：join()，将字符串、元组、列表中的元素以指定的字符(分隔符)连接生成一个新的字符串。

  - 分割：split()、partition()。

  - 替代：replace()

  - 清除空白: strip()、lstrip()、rstrip()

  .. code-block:: python
    :linenos:

    >>> s = "abcde"
    >>> "-".join(s)
    a-b-c-d-e
    >>> s = ['abc', 'def', 'ghi']
    >>> "-".join(s)
    abc_def_ghi

    >>> s = "a-b-c-d-e"
    >>> s.partion('-') ## 只能分割为3部分
    ('a', '-', 'b-c-d-e')
    >>> s.split('-')
    ['a', 'b', 'c', 'd', 'e']

- **list**

  - 索引、切片

  - 追加：append()

  - 拓展：extend()

  - 插入：insert()

  - 弹出元素：pop()

  - 移除/删除元素：remove()，del()

  - 排序：sort()

  .. code-block:: python
    :linenos:

    >>> a = [1,2,3]
    >>> a.append(4)
    [1, 2, 3, 4]
    >>> a.extend([10,20,30])
    [1, 2, 3, 4, 10, 20, 30]

    >>> a.insert(1, 5) ## 在第一个元素之后插入
    [1, 5, 2, 3, 4, 10, 20, 30]

    >>> a.remove(2)
    [1, 5, 3, 4, 10, 20, 30]
    >>> del a[3]
    [1, 5, 3, 10, 20, 30]

    >>> a.sort(reverse=True)
    [30, 20, 10, 5, 3, 1] ## 直接修改 a，无返回值。使用 sorted 返回排序后的副本。

    >>> a2 = a.pop(2)
    [1, 5, 10, 20, 30] ## a


- **dict**

  - 获取：keys()，values()，items()。

  .. code-block:: python
    :linenos:

    info ={
     "name":"Tom",
     "age":25,
     "sex":"man",
    }
    >>> info.keys()
    ['age', 'name', 'sex']
    >>> info.values()
    [25, 'Tom', 'man']
    >>> info.items()
    [('age', 25), ('name', 'Tom'), ('sex', 'man')]

  - collections.defaultdict：defaultdict类使用一种给定数据类型来初始化。当所访问的key不存在的时候，会实例化一个value作为默认值。

  .. code-block:: python
    :linenos:

    >>> from collections import defaultdict
    >>> dd = defaultdict(list) ## 使用 list 作为value type
    defaultdict(<type 'list'>, {})
    >>> dd['a']
    []
    >>> dd['b'].append("hello")
    defaultdict(<type 'list'>, {'a': [], 'b': ['hello']})

- **set**

  - 特征：无重复，无须，每个元素为不可变类型

  - 增加元素：单个元素，add()；多个元素，update()

  - 删除：删除元素不存在，remove()报错，discard()无反应。

  - 集合操作：\&，\|，\-，交差补集 \^，issubset() 、isupperset()。

  .. code-block:: python
    :linenos:

    >>> s1 = {'a', 'b', 'c'} ## 或者 s1 = set(['a', 'b', 'c'])
    >>> s1.update({'e','d'})
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
    >>> print alist
    [1, 2, 3, 5]
    >>> print b
    [1, 2, 3, 5]
    >>> print c
    [1, 2, 3]
    >>> b[0] = -1
    >>> print a
    [-1, 2, 3, 5]
    >>> print b
    [-1, 2, 3, 5]
    >>> print c
    [1, 2, 3]

- **浅复制** ：只会复制父对象，而不会复制对象的内部的子对象。

  .. code-block:: python
    :linenos:

    from copy import copy
    >>> alist = [1,2,3,['a','b']] ## ['a','b'] 是列表，是一个子对象
    >>> a_copy = copy(alist) ## dict类有copy()方法，e.g.，d.copy()
    >>> alist.append(5) ## 非子对象的修改
    >>> print alist
    [1, 2, 3, ['a', 'b'], 5]
    >>> print a_copy
    [1, 2, 3, ['a', 'b']]
    >>> a_copy[0] = -1
    >>> print alist
    [1, 2, 3, ['a', 'b'], 5]
    >>> print a_copy
    [-1, 2, 3, ['a', 'b']]

    >>> alist[3].append('c') ## 子对象的修改
    >>> print alist
    [1, 2, 3, ['a', 'b', 'c'], 5]
    >>> print a_copy
    [-1, 2, 3, ['a', 'b', 'c']]
    >>> a_copy[3].append('d')
    >>> print alist
    [1, 2, 3, ['a', 'b', 'c', 'd'], 5]
    >>> print a_copy
    [-1, 2, 3, ['a', 'b', 'c', 'd']]

- **深复制** ：复制对象及其子对象，原始对象的改变不会造成深复制里任何子元素的改变。

  .. code-block:: python
    :linenos:

    from copy import copy
    >>> alist = [1,2,3,['a','b']] ## ['a','b'] 是列表，是一个子对象
    >>> a_copy = deepcopy(alist)
    >>> alist[3].append('c') ## 子对象的修改
    >>> print alist
    [1, 2, 3, ['a', 'b', 'c']]
    >>> print a_copy
    [1, 2, 3, ['a', 'b']]
    >>> a_copy[3].append('d')
    >>> print alist
    [1, 2, 3, ['a', 'b', 'c']]
    >>> print a_copy
    [1, 2, 3, ['a', 'b', 'd']]

参考资料
------------

1. Python基本数据类型

  https://www.cnblogs.com/littlefivebolg/p/8982889.html

2. python中defaultdict方法的使用

  https://www.cnblogs.com/dancesir/p/8142775.html

3. python的复制，深拷贝和浅拷贝的区别

  https://www.cnblogs.com/xueli/p/4952063.html

4. Python学习日记之字典深复制与浅复制

  https://www.cnblogs.com/mokero/p/6662202.html
