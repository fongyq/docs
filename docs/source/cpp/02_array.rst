数组
========

动态数组
----------

地址
^^^^^

声明与定义一个动态数组的格式一般如下：

.. code-block:: cpp
    :linenos:

    int** da = new int[r];
    for(int i = 0; i < r; ++i)
    {
        da[i] = new int[c];
    }

假如我们已经得到一个3x4的动态数组，其指针关系如下：

.. image:: 02_dynamicArray.emf
