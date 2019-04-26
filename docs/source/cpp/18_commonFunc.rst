常用函数
==============

lower\_bound，upper\_bound
-------------------------------

.. highlight:: cpp

::

  #include <algorithm>

**lower_bound** 从排好序的数组区间 **[first,last)** 中，采用二分查找，返回 **大于或等于** val的 **第一个** 元素位置。
如果所有元素都小于val，则返回last。

::

  template <class ForwardIterator, class T>
  ForwardIterator lower_bound (ForwardIterator first, ForwardIterator last, const T& val);


**upper_bound** 从排好序的数组区间 **[first,last)** 中，采用二分查找，返回 **大于** val的 **第一个** 元素位置。
如果所有元素都不大于val，则返回last。

::

  template <class ForwardIterator, class T>
  ForwardIterator upper_bound (ForwardIterator first, ForwardIterator last, const T& val);


求有序数组中val的个数： ::

  upper_bound(first, last, val) - lower_bound(first, last, val);


例子：

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <vector>
  #include <algorithm>
  using namespace std;

  int main(int argc, char ** argv)
  {
    int a[11] = {1,2,3,4,5,5,5,5,6,7,8};
    cout << lower_bound(a, a + 11, 5) - a << endl; // 4
    cout << upper_bound(a, a + 11, 5) - a << endl; // 8
    vector<int> v(a, a + 11); // 用 a 对 v 初始化
    cout << lower_bound(v.begin(), v.end(), 5) - v.begin() << endl; // 4
    cout << upper_bound(v.begin(), v.end(), 5) - v.begin() << endl; // 8

    *lower_bound(a, a + 11, 5) = 500;
    for (auto ai : a) cout << ai << ends; // 1 2 3 4 500 5 5 5 6 7 8
    cout << endl;

    *lower_bound(v.begin(), v.end(), 5) = 500;
    for (auto vi : v) cout << vi << ends; // 1 2 3 4 500 5 5 5 6 7 8
    cout << endl;

    return 0;
  }



fill，fill\_n，for\_each
-----------------------------

::

  #include <algorithm>

**fill** 函数将一个区间 **[first,last)** 的每个元素都赋予val值。 ::

  template <class ForwardIterator, class T>
  void fill (ForwardIterator first, ForwardIterator last, const T& val);

**fill_n** 函数从 **first** 开始依次赋予n个元素val值。 ::

  template <class OutputIterator, class Size, class T>
  void fill_n (OutputIterator first, Size n, const T& val);

**for_each** 把函数fn应用于区间 **[first,last)** 的每个元素。 ::

  template <class InputIterator, class Function>
  Function for_each (InputIterator first, InputIterator last, Function fn);

例子：

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <vector>
  #include <algorithm>
  using namespace std;

  template<class T>
  void print(T elem){ cout << elem << " "; }

  int main(int argc, char ** argv)
  {

    float a[4] = { 0.0 }; // {0.0, 0.0, 0.0, 0.0}
    vector<int> v(4, 0); // {0, 0, 0, 0}

    fill(a, a+4, 3.3); // {3.3, 3.3, 3.3, 3.3}
    fill_n(a, 2, 6.6); // {6.6, 6.6, 3.3, 3.3}
    fill_n(v.begin(), 4, 9); // {9, 9, 9, 9}

    for_each(a, a + 4, print<float>); //  6.6 6.6 3.3 3.3
    cout << endl;
    for_each(v.begin(), v.end(), print<int>); //  9 9 9 9
    cout << endl;

    return 0;
  }

最长上升子序列：

.. code-block:: cpp
  :linenos:
  :emphasize-lines: 11-13

  /* https://leetcode.com/problems/longest-increasing-subsequence/ */
  /* O(nlogn) in time.*/

  class Solution {
  public:
      int lengthOfLIS(vector<int>& nums) {
          if(nums.size()<=1) return nums.size();
          int inf = INT_MAX;
          int len = nums.size();
          int* dp = new int[len];
          fill(dp, dp+len, inf);
          for(int k = 0; k < len; ++k) *lower_bound(dp, dp+len, nums[k]) = nums[k];
          int length = lower_bound(dp, dp+len, inf) - dp;
          delete[] dp;
          return length;
      }
  };

sort
---------

::

  #include <algorithm>

  // default
  template <class RandomAccessIterator>
  void sort (RandomAccessIterator first, RandomAccessIterator last);

  // custom
  template <class RandomAccessIterator, class Compare>
  void sort (RandomAccessIterator first, RandomAccessIterator last, Compare comp);

例子：

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <vector>
  #include <functional>
  #include <algorithm>
  using namespace std;

  bool comparator(int i, int j)
  {
    return (i < j);
  }

  struct myclass
  {
    bool operator() (int i, int j)
    {
      return (i < j);
    }
  } myobject;

  int main(int argc, char ** argv)
  {

    int a[] = { 32, 71, 12, 45, 26, 80, 53, 33 };
    vector<int> v(a, a + 8);               // 32 71 12 45 26 80 53 33

    // using default comparison (operator <):
    sort(v.begin(), v.begin() + 4);           //(12 32 45 71)26 80 53 33

    // using comparator as comp
    sort(v.begin() + 4, v.end(), comparator); // 12 32 45 71(26 33 53 80)

    // using object as comp
    sort(v.begin(), v.end(), myobject);     //(12 26 32 33 45 53 71 80)

    // using build-in comp: greater
    sort(v.begin(), v.end(), greater<int>()); // (80 71 53 45 33 32 26 12)

    // using build-in comp: less
    sort(v.begin(), v.end(), less<int>());  //(12 26 32 33 45 53 71 80)

    // using reverse_iterator
    sort(v.rbegin(), v.rend());  // (80 71 53 45 33 32 26 12)

    // sort array
    sort(a, a + 8, greater<int>());  // (80 71 53 45 33 32 26 12)
    sort(a, a + 8);                 // (12 26 32 33 45 53 71 80)，可使用 comparator、myobject、less<int>()

    return 0;
  }

附：头文件
----------------

- ``cmath``

  - pow()

  - sqrt()

- ``cstdlib``

  - abs()

  - fabs()

- ``limits``

  - INT_MIN

  - INT_MAX

- ``algorithm``

  - min()

  - max()

- ``utility``

  - pair

- ``functional``

  - less< *TYPE* >()

  - greater< *TYPE* >()

- ``cassert``

  - assert()



参考资料
--------------

1. c++ reference

  http://www.cplusplus.com/reference/algorithm/lower_bound/

  http://www.cplusplus.com/reference/algorithm/upper_bound/

  http://www.cplusplus.com/reference/algorithm/fill/

  http://www.cplusplus.com/reference/algorithm/for_each

  http://www.cplusplus.com/reference/algorithm/sort/


2. C/C++-STL中lower_bound与upper_bound的用法

  https://blog.csdn.net/jadeyansir/article/details/77015626

3. c++sort函数的使用总结

  https://www.cnblogs.com/TX980502/p/8528840.html

4. C++ sort排序函数用法

  https://blog.csdn.net/w_linux/article/details/76222112
