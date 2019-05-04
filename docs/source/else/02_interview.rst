测试
=========

汇总
----------
1. github

  - https://github.com/imhuay/Algorithm_Interview_Notes-Chinese

  - https://github.com/jwasham/coding-interview-university/blob/master/translations/README-cn.md

2. 2018校招算法岗面试题汇总

  https://zhuanlan.zhihu.com/p/36801851

编程算法
------------
1. 动态规划

  - 有面值1,5,10,20,50,100的人民币，求问10000有多少种组成方法？

      https://www.zhihu.com/question/315108379

  - 如何用最少的次数测出鸡蛋会在哪一层摔碎？

      https://www.zhihu.com/question/19690210

  - [LeetCode] Maximum Product Subarray 求连续子数组的最大乘积

      https://blog.csdn.net/xblog\_/article/details/72872263

2. 排序算法之桶排序

  https://blog.csdn.net/developer1024/article/details/79770240

3. 找出数组中N个出现1（或奇数次）次的数字

  https://www.jianshu.com/p/e1331664c8cf

4. 均匀分布生成其他分布的方法

  https://blog.csdn.net/haolexiao/article/details/60511164

5. 海量数据处理

  - 面试题集锦

      https://blog.csdn.net/v_july_v/article/details/6685962

  - 大文件中返回频数最高的100个词

      https://blog.csdn.net/tiankong\_/article/details/77240283

6. 链表

  - 求有环单链表中的环长、环起点、链表长

      https://www.cnblogs.com/xudong-bupt/p/3667729.html

  - 判断两个链表是否相交并找出交点

      https://blog.csdn.net/jiary5201314/article/details/50990349

  - 单链表O(1)时间删除给定节点

      https://blog.csdn.net/qq_35546040/article/details/80341136

7. 全排列的非递归和递归实现(含重复元素)

  https://blog.csdn.net/so_geili/article/details/71078945

8. 排列组合 "n个球放入m个盒子"问题

  https://blog.csdn.net/qwb492859377/article/details/50654627?tdsourcetag=s_pctim_aiomsg

9. Next Permutation 下一个排列

  https://www.cnblogs.com/grandyang/p/4428207.html

10. LeetCode 75. Sort Colors（三颜色排序→K颜色排序）

  https://blog.csdn.net/princexiexiaofeng/article/details/79645511

11. 找到数组第k大的数（https://leetcode.com/problems/kth-largest-element-in-an-array/）

  .. code-block:: cpp
    :linenos:
    :emphasize-lines: 14,15

    class Solution {
    public:
        int partition(vector<int>& nums, int i, int j)
        {
            int pivot = nums[i];
            int l = i+1;
            int r = j;
            while(true)
            {
                while(l<=j && nums[l]<pivot) l++;
                while(r>i && nums[r]>pivot) r--;
                if(l>=r) break;
                swap(nums[l], nums[r]);
                l++;
                r--;
            }
            swap(nums[i], nums[r]);
            return r;
        }
        int quicksort(vector<int>& nums, int a, int b, int k)
        {
            int p = partition(nums, a, b);
            if(b - p + 1 == k) return p;
            if(b - p + 1 < k) return quicksort(nums, a, p-1, k - (b - p + 1));
            else return quicksort(nums, p+1, b, k);
        }
        int findKthLargest(vector<int>& nums, int k) {
            int k_id = quicksort(nums, 0, nums.size()-1, k);
            return nums[k_id];
        }
    };

12. [LeetCode] Best Time to Buy and Sell Stock 买卖股票的最佳时间

  - 最多一次交易

      http://www.cnblogs.com/grandyang/p/4280131.html

  - 无限次交易

      http://www.cnblogs.com/grandyang/p/4280803.html

  - 最多两次交易

      http://www.cnblogs.com/grandyang/p/4281975.html

  - 最多k次交易

      http://www.cnblogs.com/grandyang/p/4295761.html

      https://blog.csdn.net/linhuanmars/article/details/23236995

  - 交易冷却

      https://www.cnblogs.com/grandyang/p/4997417.html

13. [LeetCode] Partition Equal Subset Sum 数组分成两个子集，和相等

  https://leetcode.com/problems/partition-equal-subset-sum/

  .. code-block:: python
    :linenos:
    :emphasize-lines: 2,7,9,23

    class Solution(object):
    def backtrack(self, nums, sum_nums, sum_current, i): ## self
        if sum_current == sum_nums/2:
            return True
        if i == len(nums):
            return False
        if self.backtrack(nums, sum_nums, sum_current+nums[i],i+1): ## self
            return True
        if self.backtrack(nums, sum_nums, sum_current, i+1): ## self
            return True
        return False

    def canPartition(self, nums):
        """
        :type nums: List[int]
        :rtype: bool
        """
        if len(nums) <= 1:
            return False
        sum_nums = sum(nums)
        if sum_nums % 2:
            return False
        return self.backtrack(nums, sum_nums, 0, 0) ## self

14. [LeetCode] Find All Anagrams in a String 统计变位词出现的位置。采用滑动窗口和 **计数器** 进行比较。

  https://leetcode.com/problems/find-all-anagrams-in-a-string/

  .. code-block:: cpp
    :linenos:

    /* https://leetcode.com/problems/find-all-anagrams-in-a-string/discuss/92027/C%2B%2B-O(n)-sliding-window-concise-solution-with-explanation */

    class Solution {
    public:
        vector<int> findAnagrams(string s, string p) {
            vector<int> vec;
            if(s.size()<p.size() || (s.empty() && p.empty())) return vec;
            vector<int> p_counter(26, 0), s_counter(26, 0);
            for(int i = 0; i < p.size(); ++i)
            {
                ++ p_counter[p[i]-'a'];
                ++ s_counter[s[i]-'a'];
            }
            if(p_counter == s_counter) vec.push_back(0);
            for(int i = p.size(); i < s.size(); ++i)
            {
                -- s_counter[s[i-p.size()]-'a'];
                ++ s_counter[s[i]-'a'];
                if(s_counter == p_counter) vec.push_back(i-p.size()+1);
            }
            return vec;
        }
    };


c++
------------

1. 虚函数

  https://blog.csdn.net/fighting_coder/article/details/77187151

2. 重载、重写（覆盖）和隐藏的区别

  https://blog.csdn.net/zx3517288/article/details/48976097

python
-----------

1. 基本数据类型

  https://www.cnblogs.com/littlefivebolg/p/8982889.html

2. Python中的None

  https://www.cnblogs.com/changbaishan/p/8084863.html

3. 使用lambda高效操作列表的教程

  https://www.cnblogs.com/mxp-neu/articles/5316557.html

4. 经典7大Python面试题

  https://blog.csdn.net/qq_41597912/article/details/81459804

5. 迭代器和生成器

  https://www.cnblogs.com/chongdongxiaoyu/p/9054847.html

机器学习（深度学习）
---------------------------

1. 激活函数

  https://fongyq.github.io/blog/deepLearning/02_activationFunction.html

2. Batch Normalization

  https://fongyq.github.io/blog/deepLearning/03_batchnorm.html

3. 过拟合

  https://fongyq.github.io/blog/deepLearning/03_batchnorm.html

4. 正则化项L1和L2的区别

  https://www.cnblogs.com/lyr2015/p/8718104.html

5. KMeans秘籍之如何确定K值

  https://blog.csdn.net/alicelmx/article/details/80991870

6. 决策树

  - ID3、C4.5

      https://www.cnblogs.com/coder2012/p/4508602.html

  - 预剪枝与后剪枝

      https://blog.csdn.net/zfan520/article/details/82454814

  - CART分类与回归树

      https://www.jianshu.com/p/b90a9ce05b28

7. Logistic Regression

  https://fongyq.github.io/blog/machineLearning/01_lr.html

8. Support Vector Machine

  https://fongyq.github.io/blog/machineLearning/02_svm.html

9. PCA

  https://fongyq.github.io/blog/machineLearning/03_pca.html


论文相关
-----------------

1. AlexNet/VGG/GoogleNet

  https://blog.csdn.net/gdymind/article/details/83042729

2. CNN卷积神经网络\_ GoogLeNet 之 Inception(V1-V4)

  https://www.cnblogs.com/haiyang21/p/7243200.html

3. R-CNN系列

  - 【RCNN系列】【超详细解析】

      https://blog.csdn.net/amor_tila/article/details/78809791

  - 实例分割模型Mask R-CNN详解：从R-CNN，Fast R-CNN，Faster R-CNN再到Mask R-CNN

      https://blog.csdn.net/jiongnima/article/details/79094159

  - RCNN（三）：Fast R-CNN

      https://blog.csdn.net/u011587569/article/details/52151871

4. CapsuleNet解读

  https://blog.csdn.net/u013010889/article/details/78722140/

其他
--------------

1. 理解数据库的事务，ACID，CAP和一致性

  https://www.jianshu.com/p/2c30d1fe5c4e
