编程算法
============

找出数组中的特异数字（Single Number）
-----------------------------------------------------------------

- 1 个数字出现奇数次，其余数字出现偶数次。Hint：异或运算。

- 2 个数字出现奇数次，其余数字出现偶数次。Hint：先做异或运算，得到的是这两个数的异或结果；找到该结果的二进制表示中为 1 的某一位，根据该位为 0/1 将数组分为两组，分别做异或运算。

  https://www.jianshu.com/p/e1331664c8cf

- 1 个数字出现 :math:`1` 次，其余数字出现 :math:`k` 次。Hint：利用大小为 32 的数组，统计二进制各位出现 1 的次数，对 :math:`k` 取模；最终 32 位数组的值就是 Single Number 的二进制表示。

  https://cloud.tencent.com/developer/article/1131946

- 一般情形：1 个数字出现 :math:`p` 次，其余数字出现 :math:`k` 次。

  https://blog.csdn.net/wlwh90/article/details/89712795

  https://cloud.tencent.com/developer/article/1131945

  https://leetcode.com/problems/single-number-ii/discuss/43295/Detailed-explanation-and-generalization-of-the-bitwise-operation-method-for-single-numbers


均匀分布生成其他分布的方法
-----------------------------------------------------------------

Hint：中心极限定理。

https://blog.csdn.net/haolexiao/article/details/60511164

海量数据处理
-----------------------------------------------------------------

Hint：哈希方法，把大文件划分成小文件，读进内存依次处理，如果需要统计频率/个数，再用哈希表；Bitmap，用一个（或几个）比特位来标记某个元素对应的值。

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:
        
        // Bitmap       

        #include <iostream>
        #include <bitset>
        using namespace std;

        const int BITSPERWORD = 32;
        const int SHIFT = 5;        // i / 32 = i >> 5
        const int MASK = 0x1f;      // i % 32 = i & 0x1f
        const int N = 10000;
        int a[1 + N/BITSPERWORD];

        // 设置第 i 位为 1
        inline void set(int i)
        {
            a[i >> SHIFT] |= 1 << (i & MASK);
        }
        // 设置第 i 位为 0
        inline void clear(int i)
        {
            a[i >> SHIFT] &= ~ (1 << (i & MASK));
        }
        // 检查第 i 位的值是否为 0
        inline int test(int i)
        {
            return a[i >> SHIFT] & (1 << (i & MASK));
        }

        int main()
        {
            set(40);
            cout << bitset<BITSPERWORD>(a[40 >> SHIFT]) << endl; // 00000000000000000000000100000000
            cout << test(40) << endl;
            return 0;
        }

- 面试题集锦

  https://blog.csdn.net/v_july_v/article/details/6685962

- 大文件中返回频数最高的100个词

  https://blog.csdn.net/tiankong\_/article/details/77240283


链表
-----------------------------------------------------------------

**对每一个节点操作之前，应先考虑该节点是否为空。**

- [LeetCode] Reverse Linked List 反转链表。Hint：方法一，逐个反转；方法二，递归；方法三，使用栈保存节点的值，反向赋给所有节点。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        struct ListNode 
        {
            int val;
            ListNode *next;
            ListNode() : val(0), next(nullptr) {}
            ListNode(int x) : val(x), next(nullptr) {}
            ListNode(int x, ListNode *next) : val(x), next(next) {}
        };

    .. code-block:: cpp
        :linenos:

        // 方法一，逐个反转
        ListNode* reverseList(ListNode* head) 
        {
            if(!head || !head->next) return head;
            ListNode* curr = head->next;
            head->next = nullptr;
            while(curr)
            {
                ListNode* post = curr->next;
                curr->next = head;
                head = curr;
                curr = post;
            }
            return head;
        }

    .. code-block:: cpp
      :linenos:

      // 方法二，递归
      ListNode* reverseList(ListNode* head)
      {
          if(head == nullptr || head->next == nullptr) return head;
          else
          {
              ListNode* newHead = reverseList(head->next);
              head->next->next = head; // head 指向的下一个节点是 newHead 的最后一个节点
              head->next = nullptr;
              return newHead;
          }
      }

    .. code-block:: cpp
      :linenos:

      // 方法三，使用栈保存节点的值，占用 O(n) 额外空间
      ListNode* reverseList(ListNode* head)
      {
          if(head == nullptr || head->next == nullptr) return head;
          stack<int> stk;
          ListNode* p = head;
          while(p)
          {
              stk.emplace(p->val);
              p = p->next;
          }
          p = head;
          while(p)
          {
              p->val = stk.top();
              stk.pop();
              p = p->next;
          }
          return head;
      }

- [LeetCode] Reverse Nodes in k-Group 从头节点开始，每 :math:`k` 个节点为一组进行反转。Hint：对每一组节点调用反转函数。延伸：从尾节点开始，每 :math:`k` 个节点为一组进行反转。Hint：先反转整个链表；按上述方法反转每一组；再反转整个链表。

  https://leetcode.com/problems/reverse-nodes-in-k-group/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 从头节点开始分组

      class Solution
      {
      public:
          ListNode* reverseKGroup(ListNode* head, int k)
          {
              return reverseK(head, k);
          }
      private:
          ListNode* reverseAll(ListNode* head)
          {
              if(!head || !head->next) return head;
              ListNode* newHead = reverseAll(head->next);
              head->next->next = head;
              head->next = nullptr;
              return newHead;
          }
          ListNode* reverseK(ListNode* head, int k)
          {
              if(!head || !head->next) return head;
              ListNode* p = head;
              for(int i = 1; i < k; ++i)
              {
                  p = p->next;
                  if(!p) return head;
              }
              ListNode* secondHead = reverseK(p->next, k);
              p->next = nullptr; // 第一组的尾节点置为 NULL，便于直接调用 reverseAll
              ListNode* newHead = reverseAll(head);
              head->next = secondHead; // 反转之后，head 成为第一组的尾节点
              return newHead;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 从尾节点开始分组

      ListNode* reverseKGroup(ListNode* head, int k)
      {
          ListNode* newHead = reverseAll(head);
          newHead = reverseK(newHead, k);
          newHead = reverseAll(newHead);
          return newHead;
      }

- 求有环单链表中的环长、环起点、链表长。Hint：快慢指针。

  https://www.cnblogs.com/xudong-bupt/p/3667729.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 判断链表是否有环

      class Solution
      {
      public:
          bool hasCycle(ListNode *head)
          {
              if(!head || !head->next) return false;
              ListNode* slow = head;
              ListNode* fast = head;
              while(fast && fast->next)
              {
                  slow = slow->next;
                  fast = fast->next->next;
                  if(slow == fast) return true;
              }
              return false;
          }
      };

- 判断两个链表是否相交并找出交点。Hint：方法一，先求两个链表的长度差，双指针法；方法二，分别用栈保存两个链表的节点的地址（指针），从后往前比较。如果只需要判断两个链表是否相交，只需判断两个链表最后一个节点是否相同。

  https://blog.csdn.net/jiary5201314/article/details/50990349

- 单链表 :math:`\mathcal{O}(1)` 时间删除给定节点。Hint：交换当前节点与下一个节点的值，删除下一个节点。

  https://blog.csdn.net/qq_35546040/article/details/80341136

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      bool removeNode(ListNode* pNode)
      {
          if(pNode == nullptr) return true;
          if(pNode->next == nullptr) return false;
          pNode->val = pNode->next->val;
          pNode->next = pNode->next->next;
          return true;
      }
      // 注：如果需要删除最后一个节点，直接令 pNode->next = nullptr 是无法改变实参的（传值调用），可以将形参定义成指向指针的指针
      // 必须从链表头节点开始遍历，找到该节点的前驱节点
      // 还要考虑该链表只有一个节点的情形
      // 另外，可以在该函数内 delete 该指针，但是需要确保在其他地方不再需要访问 pNode 指向的内容

- 输出该链表中倒数第 :math:`k` 个节点。Hint：双指针法，第一个指针先走 :math:`k-1` 步，然后第二个指针从头节点开始，与第一个指针同步往后移；当第一个指针移到最后一个节点，第二个指针即指向倒数第 :math:`k` 个节点。延伸：删除倒数第 :math:`k` 个节点，需要注意删除头节点的情况。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      ListNode* FindKthToTail(ListNode* pListHead, unsigned int k)
      {
          if(!pListHead || k == 0) return nullptr;

          unsigned int tk = 1;
          ListNode* p = pListHead;
          while(tk < k)
          {
              p = p->next;
              if(!p) return nullptr;
              tk += 1;
          }

          ListNode* pk = pListHead;
          while(p->next)
          {
              p = p->next;
              pk = pk->next;
          }
          return pk;
      }

    .. code-block:: cpp
      :linenos:

      // 删除倒数第 k 个节点
      ListNode* removeNthFromEnd(ListNode* head, int n) 
      {
          if(!head || n <= 0) return head;
          ListNode* pre = head;
          ListNode* post = head;
          for(int i = 0; i < n; ++i)
          {
              post = post->next;
              if(!post)
              {
                  if(i < n-1) return head;
                  else
                  // 删除头节点
                  {
                      pre = head->next;
                      delete(head);
                      return pre;
                  }
              }
          }
          while(post->next)
          {
              pre = pre->next;
              post = post->next;
          }
          post = pre->next->next;
          delete(pre->next);
          pre->next = post;
          return head;
      }


- [LeetCode] Sort List 链表排序。Hint：方法一，快速排序或归并排序；方法二，遍历链表把值存入数组，使用数组的排序方法，再把值赋回链表。

  https://leetcode.com/problems/sort-list/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 快速排序

      class Solution
      {
      public:
          ListNode* sortList(ListNode* head)
          {
              quickSort(head, nullptr);
              return head;
          }
      private:
          // 由于链表无法反向遍历，需要重新考虑如何交换两个位置的数值
          // pre 指向 curr 的前一个数，或者指向第一个比 key 大的数的前一个数
          // 当 curr 指向的数比 key 小，pre 移到下一位，交换两者的值
          ListNode* partion(ListNode* head, ListNode* tail)
          {
              int key = head->val;
              ListNode* pre = head;
              ListNode* curr = head->next;
              while(curr != tail)
              {
                  if(curr->val < key)
                  {
                      pre = pre->next;
                      swap(pre->val, curr->val);
                  }
                  curr = curr->next;
              }
              swap(head->val, pre->val);
              return pre;
          }
          void quickSort(ListNode* head, ListNode* tail)
          {
              if(head == tail || (head->next) == tail) return;
              ListNode* mid = partion(head, tail);
              quickSort(head, mid);
              quickSort(mid->next, tail);
          }
      };

    .. code-block:: cpp
      :linenos:

      // 归并排序

      class Solution
      {
      private:
          ListNode* getMid(ListNode* head)
          {
              if(!head || !head->next) return head;
              ListNode* slow = head;
              ListNode* fast = head->next;
              while(fast && fast->next)
              {
                  slow = slow->next;
                  fast = fast->next->next;
              }
              return slow;
          }
          ListNode* merge(ListNode* head1, ListNode* head2)
          {
              // 可以 new 一个节点作为临时头节点，代码会更简洁，但是会增加空间开销、降低时间效率
              if(!head1) return head2;
              if(!head2) return head1;
              ListNode* tmp_head;
              if(head1->val <= head2->val)
              {
                  tmp_head = head1;
                  head1 = head1->next;
              }
              else
              {
                  tmp_head = head2;
                  head2 = head2->next;
              }
              ListNode* p = tmp_head;
              while(head1 && head2)
              {
                  if(head1->val <= head2->val)
                  {
                      p->next = head1;
                      head1 = head1->next;
                  }
                  else
                  {
                      p->next = head2;
                      head2 = head2->next;
                  }
                  p = p->next;
              }
              if(head1) p->next = head1;
              if(head2) p->next = head2;
              return tmp_head;
          }
          ListNode* mergeSort(ListNode* head)
          {
              if(!head || !head->next) return head;
              ListNode* mid = getMid(head);
              ListNode* head_post = mid->next;
              mid->next = nullptr;
              head = mergeSort(head);
              head_post = mergeSort(head_post);
              return merge(head, head_post);
          }
      public:
          ListNode* sortList(ListNode* head)
          {
              return mergeSort(head);
          }
      };

- 将二叉搜索树转换为升序排序的双向链表。Hint：中序遍历。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      struct TreeNode
      {
          int val;
          struct TreeNode *left;
          struct TreeNode *right;
          TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
      };

      class Solution
      {
      public:
          TreeNode* Convert(TreeNode* pRootOfTree)
          {
              pRootOfTree = converTree2List(pRootOfTree);
              return pRootOfTree;
          }
      private:
          // 返回的是转换之后的链表的头节点
          TreeNode* converTree2List(TreeNode* root)
          {
              if(!root) return nullptr;

              TreeNode* l = converTree2List(root->left);
              while(l && l->right) l = l->right; // 根节点应该接在左子树链表的尾节点之后
              if(l) l->right = root;
              root->left = l;

              TreeNode* r = converTree2List(root->right);
              if(r) r->left = root;
              root->right = r; // 根节点应该接在右子树链表的头节点之前

              while(root->left) root = root->left; // 找到头节点
              return root;
          }
      };

- 删除链表中的重复节点。Hint：可能会删除头节点；注意尾节点处是否有重复元素。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          ListNode* deleteDuplicates(ListNode* head)
          {
              if(!head || !head->next) return head;
              ListNode* tmp_head = new ListNode(-1);
              tmp_head->next = head;
              ListNode* pre = tmp_head;
              ListNode* curr = head;
              while(curr && curr->next)
              {
                  if(curr->val == curr->next->val)
                  {
                      while(curr->next && curr->val == curr->next->val) curr = curr->next;
                      curr = curr->next;
                      if(!curr || !curr->next) pre->next = curr;
                  }
                  else
                  {
                      pre->next = curr;
                      pre = curr;
                      curr = curr->next;
                  }
              }
              head = tmp_head->next;
              delete(tmp_head); tmp_head = nullptr;
              return head;
          }
      };


- 重组链表，首尾交错，L0→L1→…→Ln-1→Ln 转换为 L0→Ln→L1→Ln-1→L2→Ln-2→…。Hint：首先，链表中间截断；然后，第二段链表翻转；最后，合并两个子链表。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          void reorderList(ListNode* head)
          {
              if(!head || !head->next || !head->next->next) return;

              // 第一步：找到中间节点
              ListNode* slow = head;
              ListNode* fast = head;
              while(fast && fast->next)
              {
                  slow = slow->next;
                  fast = fast->next->next;
              }

              // 第二步：翻转第二段链表
              ListNode* secondHead = slow->next;
              slow->next = nullptr; // 第一段链表的尾节点
              ListNode* p = secondHead->next;
              secondHead->next = nullptr; // 第二段链表的尾节点
              ListNode* q;
              while(p)
              {
                  q = p->next;
                  p->next = secondHead;
                  secondHead = p;
                  p = q;
              }

              // 第三步：交叉合并两个子链表
              ListNode* h1 = head;
              ListNode* h2 = secondHead;
              while(h1 && h2)
              {
                  ListNode* h1Post = h1->next;
                  ListNode* h2Post = h2->next;
                  h1->next = h2;
                  h2->next = h1Post;
                  h1 = h1Post;
                  h2 = h2Post;
              }
          }
      };

- [LeetCode] Partition List 分割链表，小于 :math:`x` 的排前面，不小于 :math:`x` 的排后面。Hint：建立两个新的链表，一个链表连接小于 :math:`x` 的节点，另一个链表连接其他节点，最后把这两个链表串起来。

  https://leetcode.com/problems/partition-list/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution 
      {
      public:
          ListNode* partition(ListNode* head, int x) 
          {
              if(!head || !head->next) return head;
              ListNode* h1 = new ListNode(x);
              ListNode* p1 = h1;
              ListNode* h2 = new ListNode(x);
              ListNode* p2 = h2;
              ListNode* q = head;
              while(q)
              {
                  if(q->val < x)
                  {
                      p1->next = q;
                      p1 = p1->next;
                  }
                  else
                  {
                      p2->next = q;
                      p2 = p2->next;
                  }
                  q = q->next;
              }
              p2->next = nullptr; // 尾节点置为空
              p1->next = h2->next;
              head = h1->next;
              delete h1;
              delete h2;
              return head;
          }
      };

[LeetCode] Sort Colors 三颜色排序
-----------------------------------------------------------------

https://blog.csdn.net/princexiexiaofeng/article/details/79645511

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          void sortColors(vector<int>& nums)
          {
              if(nums.size() <= 1) return;
              int left = 0;
              int right = nums.size() - 1;
              for(int mid = left; mid <= right; ++mid)
              {
                  while(nums[mid] == 2 && mid < right)
                  {
                      swap(nums[mid], nums[right]);
                      right--;
                  }
                  while(nums[mid] == 0 && mid > left)
                  {
                      swap(nums[mid], nums[left]);
                      left++;
                  }
              }
          }
      };

      // 注：要先判断 nums[mid] == 2，再判断 nums[mid] == 0，否则会出错，如 [1,2,0]
      // 因为 2 是往后交换，0 是往前交换；2 交换得到的可能是 0，但可以保证 0 交换得到的不会是 2，因为 2 在 0 之前被处理了
      // 如果判断顺序反过来，2 交换得到的 0 不会被处理

找到数组第 :math:`k` 大的数
-----------------------------------------------------------------

https://leetcode.com/problems/kth-largest-element-in-an-array/

- 排序。时间复杂度 :math:`\mathcal{O}(N \log N)` 。

- 伪排序：:math:`k` 次遍历数组，每次从剩余数字中找一个最大值。时间复杂度 :math:`\mathcal{O}(kN)` 。

- 借助大小为 :math:`k` 的最小堆。时间复杂度 :math:`\mathcal{O}(N \log k)` 。

- 快排思想。时间复杂度 :math:`\mathcal{O}(N)` 。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:
      :emphasize-lines: 7,8,15,16,24,25,26,29,30

      class Solution
      {
      public:
          int partition(vector<int>& nums, int i, int j)
          {
              int pivot = nums[i];
              int l = i+1;
              int r = j;
              while(true)
              {
                  while(l <= j && nums[l] < pivot) l++;
                  while(r > i && nums[r] > pivot) r--;
                  if(l >= r) break;
                  swap(nums[l], nums[r]);
                  l++;
                  r--;
              }
              swap(nums[i], nums[r]);
              return r;
          }
          // partition 可用如下更简洁的形式
          int partition(vector<int>& nums, int i, int j)
          {
              int pivot = nums[i];
              int l = i;
              int r = j+1;
              while(true)
              {
                  while(nums[++l] < pivot && l < j);
                  while(nums[--r] > pivot);
                  if(l >= r) break;
                  swap(nums[l], nums[r]);
              }
              swap(nums[i], nums[r]);
              return r;
          }

          // T(n) = T(n/2) + O(n)，时间复杂度 O(n)
          int quicksort(vector<int>& nums, int a, int b, int k)
          {
              int p = partition(nums, a, b);
              if(b - p + 1 == k) return p;
              if(b - p + 1 < k) return quicksort(nums, a, p-1, k - (b - p + 1));
              else return quicksort(nums, p+1, b, k);
          }
          int findKthLargest(vector<int>& nums, int k)
          {
              int k_id = quicksort(nums, 0, nums.size()-1, k);
              return nums[k_id];
          }
      };



[LeetCode] Best Time to Buy and Sell Stock 买卖股票的最佳时间
--------------------------------------------------------------------------------
  
- 最多一次交易

  http://www.cnblogs.com/grandyang/p/4280131.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxProfit(vector<int>& prices)
          {
              if(prices.size() <= 1) return 0;
              int profit = 0;
              int minimal = INT_MAX;
              for(int p: prices)
              {
                  profit = max(profit, p - minimal);
                  minimal = min(p, minimal);
              }
              return profit;
          }
      };

- 无限次交易

  http://www.cnblogs.com/grandyang/p/4280803.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxProfit(vector<int>& prices)
          {
              if(prices.size() <= 1) return 0;
              int profit = 0;
              for(int i = 0; i < prices.size() - 1; ++i) profit += max(prices[i+1] - prices[i], 0);
              return profit;
          }
      };

- 最多两次交易

  http://www.cnblogs.com/grandyang/p/4281975.html

- 最多k次交易

  http://www.cnblogs.com/grandyang/p/4295761.html

  https://blog.csdn.net/linhuanmars/article/details/23236995

- 交易冷却

  https://www.cnblogs.com/grandyang/p/4997417.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // buy[i] = max(buy[i-1], cool[i-1] - prices[i])
      // sell[i] = max(sell[i-1], buy[i-1] + prices[i])
      // cool[i] = sell[i-1] => buy[i] = max(buy[i-1], sell[i-2] - prices[i])

      class Solution
      {
      public:
          int maxProfit(vector<int>& prices)
          {
              if(prices.size() <= 1) return 0;
              int pre_sell = 0;
              int sell = 0;
              int pre_buy = INT_MIN;
              int buy = 0;
              for(int p : prices)
              {
                  buy = max(pre_buy, pre_sell - p); // 这里的 pre_sell 其实是 pre_pre_sell
                  pre_sell = sell; // pre_sell 更新晚一步
                  sell = max(pre_sell, pre_buy + p);
                  pre_buy = buy;
              }
              return sell;
          }
      };

[LeetCode] Partition Equal Subset Sum 数组分成两个子集，和相等
-------------------------------------------------------------------------------

https://leetcode.com/problems/partition-equal-subset-sum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:
      :emphasize-lines: 2,7,9,23

      class Solution(object):
          def backtrack(self, nums, sum_nums, sum_current, i): ## self
              if sum_current == sum_nums / 2:
                  return True
              if i == len(nums):
                  return False
              if self.backtrack(nums, sum_nums, sum_current+nums[i], i+1): ## self
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


[LeetCode] Find All Anagrams in a String 统计变位词出现的位置
-------------------------------------------------------------------------------

Hint：采用滑动窗口和 **计数器** 进行比较。

https://leetcode.com/problems/find-all-anagrams-in-a-string/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      /* https://leetcode.com/problems/find-all-anagrams-in-a-string/discuss/92027/C%2B%2B-O(n)-sliding-window-concise-solution-with-explanation */

      class Solution
      {
      public:
          vector<int> findAnagrams(string s, string p)
          {
              vector<int> vec;
              if(s.size()<p.size() || (s.empty() && p.empty())) return vec;
              vector<int> p_counter(26, 0), s_counter(26, 0);
              for(int i = 0; i < p.size(); ++i)
              {
                  ++p_counter[p[i]-'a'];
                  ++s_counter[s[i]-'a'];
              }
              if(p_counter == s_counter) vec.push_back(0);
              for(int i = p.size(); i < s.size(); ++i)
              {
                  --s_counter[s[i-p.size()]-'a'];
                  ++s_counter[s[i]-'a'];
                  if(s_counter == p_counter) vec.push_back(i-p.size()+1);
              }
              return vec;
          }
      };


寻找重复数
-------------------------------------------------------------------------------

数值范围为 :math:`\{ 1,2,3,...,n \}` ，有的出现 2 次，有的出现 1 次。Hint：把数组元素的值当做下标，由于元素存在重复，因此必然会 **重复多次访问同一个位置** 。
从另一个角度讲，访问序列中存在“环”。排序的时间复杂度高，哈希不满足空间复杂度为 :math:`\mathcal{O}(1)` 的要求。

- [LeetCode] Find the Duplicate Number 找到一个重复数字（共有 :math:`n+1` 个数）。

  https://leetcode.com/problems/find-the-duplicate-number/

  http://www.cnblogs.com/grandyang/p/4843654.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 解法一：快慢指针，寻找某个“环”的入口
      class Solution
      {
      public:
          int findDuplicate(vector<int>& nums)
          {
              int slow = 0, fast = 0, t = 0;
              while (true)
              {
                  slow = nums[slow]; // 注意，这里下标没有减 1
                  fast = nums[nums[fast]];
                  if (slow == fast) break;
              }
              while (true)
              {
                  slow = nums[slow];
                  t = nums[t];
                  if (slow == t) break;
              }
              return slow;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 解法二：不断交换位置，找到第一个重复访问的元素
      class Solution
      {
      public:
          int findDuplicate(vector<int>& nums)
          {
              int duplicate = -1;
              for(int k = 0; k < nums.size(); ++k)
              {
                  while(nums[k]-1 != k)
                  {
                      if(nums[k] == nums[nums[k]-1])
                      {
                          duplicate = nums[k];
                          break;
                      }
                      swap(nums[k], nums[nums[k]-1]);
                      // 一次交换之后，下标为 nums[k]-1 的元素就等于 nums[k] 了。
                  }
                  if(duplicate != -1) break;
              }
              return duplicate;
          }
      };


- [LeetCode] Find All Duplicates in an Array 找到所有重复数字（共有 :math:`n` 个数）。

  https://leetcode.com/problems/find-all-duplicates-in-an-array/

  http://www.cnblogs.com/grandyang/p/6209746.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 解法一：将访问过的元素置为相反数（负数），如果下次访问到一个负数，说明这个元素被重复访问
      class Solution
      {
      public:
          vector<int> findDuplicates(vector<int>& nums)
          {
              vector<int> res;
              for (int i = 0; i < nums.size(); ++i)
              {
                  int idx = abs(nums[i]) - 1;
                  if (nums[idx] < 0) res.push_back(idx + 1);
                  else nums[idx] = -nums[idx];
              }
              return res;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 解法二：不断交换位置使得 i == nums[i]-1
      class Solution 
      {
      public:
          vector<int> findDuplicates(vector<int>& nums) 
          {
              vector<int> duplicate;
              for(int i = 0; i < nums.size(); ++i)
              {
                  while(nums[nums[i] - 1] != nums[i]) swap(nums[i], nums[nums[i] - 1]);
              }
              for(int i = 0; i < nums.size(); ++i)
              {
                  if(i != nums[i] - 1) duplicate.push_back(nums[i]);
              }
              return duplicate;
          }
      };

- [LeetCode] First Missing Positive 找到第一个消失的正整数。Hint：假设数组长度为 :math:`n` ，则第一个消失的正整数所在区间是 :math:`[1, n+1]` ，注意：输入数组中可能存在负数和0。延伸：找到第一个大于 :math:`K` 的正整数。Hint：可知目标数所在区间是 :math:`[K+1, K+n+1]` ；先删除数组中不在该区间的整数；其余数都减 :math:`K` ，范围变成 :math:`[1, n+1]` ，后续解法同上。

  https://leetcode.com/problems/first-missing-positive/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 解法一：将访问过的元素置为相反数（负数）
      class Solution 
      {
      public:
          int firstMissingPositive(vector<int>& nums) 
          {
              int n = nums.size();
              for(auto& m: nums) if(m <= 0) m = n + 1; // 先处理非正整数，全部置为 n+1
              for(auto& m: nums)
              {
                  int i = abs(m) - 1;
                  if(i < n && nums[i] > 0) nums[i] = -nums[i];
              }
              for(int i = 0; i < n; ++i)
              {
                  if(nums[i] > 0) return i+1;
              }
              return n + 1;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 解法二：不断交换位置使得 i == nums[i]-1
      class Solution 
      {
      public:
          int firstMissingPositive(vector<int>& nums) 
          {
              int n = nums.size();
              for(auto& m: nums)
              {
                  while(m > 0 && m <= n && m != nums[m-1]) swap(m, nums[m-1]);
              }
              for(int i = 0; i < n; ++i)
              {
                  if(nums[i] != i + 1) return i+1;
              }
              return n+1;
          }
      };

[LeetCode] Spiral Matrix 环形打印矩阵
-------------------------------------------------------------------------------

https://leetcode.com/problems/spiral-matrix/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          void tranverseMatrixAccorindTo4Directions(vector<vector<int>> &matrix, const unsigned int row, const unsigned int col, int start, vector<int>& vec)
          {
              // 特别注意
              // 如果把 start, endX, endY, k 声明为 unsigned int 类型，在减到 0 的时候可能会死循环，因为 unsigned int 类型不会小于 0。

              int endX = row - 1 - start;
              int endY = col - 1 - start;

              // 1 向右
              for(int k = start; k <= endY; ++k) vec.push_back(matrix[start][k]);

              // 2 向下
              for(int k = start+1; k <= endX; ++k) vec.push_back(matrix[k][endY]);

              // 3 向左：要求至少存在两行（不加判断会重复扫描同一行）
              if(endX > start) for(int k = endY-1; k >= start; --k) vec.push_back(matrix[endX][k]);

              // 4 向上：要求至少存在两列（不加判断会重复扫描同一列）
              if(endY > start) for(int k = endX-1; k > start; --k) vec.push_back(matrix[k][start]);

          }
          vector<int> spiralOrder(vector<vector<int>>& matrix)
          {
              vector<int> vec;
              unsigned int row = matrix.size();
              if(row == 0) return vec;
              unsigned int col = matrix[0].size();
              if(col == 0) return vec;
              int start = 0;
              // 循环中止条件：圈数判断（ (start,start) 是每一圈的入口坐标）
              while(start * 2 < row && start * 2 < col)
              {
                  tranverseMatrixAccorindTo4Directions(matrix, row, col, start, vec);
                  ++start;
              }
              return vec;
          }
      };


[LeetCode] Longest Consecutive Sequence 最长连续序列
-------------------------------------------------------------------------------

Hint：方法一，排序；方法二，对于每个元素 :math:`n` ，搜索 :math:`n+1` 是否在数组中，使用 hash/set 可以获得 :math:`\mathcal{O}(1)` 的查找复杂度。

https://leetcode.com/problems/longest-consecutive-sequence/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      class Solution(object):
          def longestConsecutive(self, nums):
              """
              :type nums: List[int]
              :rtype: int
              """

              longest = 0
              num_set = set(nums)

              for num in nums:
                  if num-1 not in num_set:
                      current_long = 1
                      while num + 1 in num_set:
                          current_long += 1
                          num += 1
                      longest = max(longest, current_long)

              num_set.clear()

              return longest



跳跃的蚂蚱
-------------------------------------------------------------------------------

从 0 点出发，往正或负向跳跃，第一次跳跃一个单位，之后每次跳跃距离比上一次多一个单位，跳跃多少次可到到达坐标 :math:`x` 处？
Hint：走 :math:`n` 步之后能到达的坐标是一个公差为 2 的等差数列（如 :math:`n=2` ，可到达 :math:`\{-3,-1,1,3\}` ）。
只需找到最小的 :math:`n` 使得

.. math::

  (1+2+...+n) - x = \frac{n(n+1)}{2} - x

是非负偶数。跳到 :math:`x` 和跳到 :math:`-x` 的次数相同，
因此只考虑 :math:`x` 为正的情况。

https://www.zhihu.com/question/50790221

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 作者：Rukia
      // 链接：https://www.zhihu.com/question/50790221/answer/125213696

      int minStep(int x)
      {
      	if (x == 0) return 0;
      	if (x < 0) x = -x;
      	int n = sqrt(2*x); // 快速找到一个接近答案的 n
      	while ((n+1)*n/2-x & 1 || (n+1)*n/2 < x) // & 的优先级低
      		++n;
      	return n;
      }


求 :math:`n` 的阶乘末尾有多少个 :math:`0` 
-------------------------------------------------------------------------------

Hint：1 个 :math:`5` 和1个 :math:`2` 搭配可以得到 1 个 :math:`0` ；:math:`2` 的个数比 :math:`5` 多，
因此只关心 :math:`5` 的个数；:math:`25` 包含 2 个 :math:`5` ，:math:`125` 包含 3 个 :math:`5` ...。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int trailingZeroes(int n)
          {
              if(n <= 0) return 0;
              int res = 0;
              while(n)
              {
                  res += n / 5;
                  n /= 5;
              }
              return res;
          }
      };


求一个整数的二进制表示中 :math:`1` 的个数
-------------------------------------------------------------------------------

Hint：移位操作；负数可能造成死循环。 

**C++中，指定移位次数大于或等于对象类型的比特数（如 int 型的 32 位），或者对负数进行左移操作，结果都是未定义的** 。
例如：``n >> 32`` 是未定义的，但是允许 ``n >>= 1`` 执行无限次，这是安全的。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一：不断右移 n。如果 n 是负数，需要保持最高位为 1，不断移位后这个数字会变成 0xFFFFFFFF 而陷入死循环。
      int numberOf1(int n)
      {
        int cnt = 0;
        while(n)
        {
          if(n & 1) cnt++;
          n >>= 1;
        }
        return cnt;
      }

    .. code-block:: cpp
      :linenos:

      // 方法二：n 不动，左移一个比较子。
      int numberOf1(int n)
      {
        int cnt = 0;
        unsigned int flag = 1;
        while(flag) // 连续左移32次之后为0
        {
          if(n & flag) cnt++;
          flag <<= 1;
        }
        return cnt;
      }


    .. code-block:: cpp
      :linenos:

      // 方法三：把一个整数减 1，再和原整数做逻辑与运算，会把该整数最右边的一个 1 变成 0。
      int numberOf1(int n)
      {
        int cnt = 0;
        while(n)
        {
          cnt++;
          n = (n - 1) & n;
        }
        return cnt;
      }


[LeetCode] Subarray Sum Equals K 子数组和为 :math:`K` 
-------------------------------------------------------------------------------

Hint：依次求数组的前 :math:`n` 项和 :math:`s[n]` ，:math:`n \in [0, N]` （注意：0 也在内），
将和作为哈希表的 key，和的值出现次数作为 value；如果存在 :math:`s[i]−s[j]=K \ (i \gt j)` ，则 :math:`s[i]` 和 :math:`s[j]` 都应该在哈希表中。

https://leetcode.com/problems/subarray-sum-equals-k/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      ## https://leetcode.com/problems/subarray-sum-equals-k/solution/ : Approach #4 Using hashmap

      from collections import defaultdict
      class Solution(object):
          def subarraySum(self, nums, k):
              """
              :type nums: List[int]
              :type k: int
              :rtype: int
              """

              if len(nums) == 0:
                  return 0

              N = len(nums)

              sum_to_num = defaultdict(int)
              sum_to_num[0] = 1 ## 前 0 项和

              cnt = 0
              tmp_sum = 0
              for n in nums:
                  tmp_sum += n
                  diff = tmp_sum - k
                  cnt += sum_to_num[diff]
                  sum_to_num[tmp_sum] += 1

              return cnt


延伸：和不小于 :math:`K` 的最短子数组。Hint：滑动窗口 + 单调 deque，时间复杂度和空间复杂度都是 :math:`\mathcal{O}(N)` 。

https://leetcode.com/problems/shortest-subarray-with-sum-at-least-k

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        from collections import deque
        class Solution:
            def shortestSubarray(self, nums: List[int], k: int) -> int:
                ans = float('inf')
                s = 0
                dq = deque() ## (s, i)
                for i in range(len(nums)):
                    s += nums[i]
                    if s >= k:
                        ans = min(ans, i + 1)
                    ## 以 i 为窗口右边界，收拢左边界
                    while dq and s - dq[0][0] >= k:
                        ans = min(ans, i - dq[0][1])
                        dq.popleft()
                    ## 保持 dq 是单调增队列
                    ## dq[-1][0] > s 说明数组在区间 [dq[-1][0] + 1, i] 的和是负数
                    ## 因此 dq[-1][0] + 1 不可能是右边界在 i 之后的任何最短子数组的左边界
                    while dq and dq[-1][0] > s:
                        dq.pop()
                    dq.append((s, i))
                return ans if ans != float('inf') else -1


使用位运算进行加法运算
-------------------------------------------------------------------------------

Hint：原位加法运算等效为 ``^`` 运算，进位等效为 ``&`` 和 ``移位`` 的复合。 **注：C++不允许对负数进行左移运算。**

https://leetcode.com/problems/sum-of-two-integers/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int getSum(int a, int b)
          {
              int sum, carry;
              do
              {
                  sum = (a ^ b);
                  carry = (a & b & INT_MAX) << 1; // & INT_MAX 操作保证移位前的数是正数，否则结果是未定义的。
                  a = sum;
                  b = carry;
              }while(b != 0);
              return a;
          }
      };

    .. code-block:: python
      :linenos:

      from numpy import int32

      class Solution(object):
          def getSum(self, a, b):
              """
              :type a: int
              :type b: int
              :rtype: int
              """
              a, b = int32(a), int32(b)

              while True:
                  a, b = a ^ b, (a & b) << 1
                  print a, b
                  if b == 0:
                      break

              return int(a)

      ## 注意，这里并没有与 0x7fffffff 做 & 运算
      ## 假设 a & b = -16，-16 & 0x7fffffff = 2147483632
      ## C++ 中，对 2147483632 左移1位使得最高位符号位为 1，得到 -32
      ## python中，2147483632的符号位为 0，继续左移1位，会直接做大整数运算，得到 4294967264L，导致不能得到正确结果
      ## python 中，使用type()查看数据类型时发现，有时候系统会把 int32 转化为 int64，或者 int64 转为 int32，疑惑中。。。


[LeetCode] Longest Substring with At Least K Repeating Characters 包含重复字符的最长子串
---------------------------------------------------------------------------------------------------------------------------------------------

Hint：由于该字符串只包含小写字母，因此直接使用长度为26的静态数组来统计字符频率更为简洁高效，不需要使用map。

https://leetcode.com/problems/longest-substring-with-at-least-k-repeating-characters/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // https://www.cnblogs.com/grandyang/p/5852352.html
      // 使用一个int型（32位）的mask，指示各字符频率是否到达k
      // 以每一个字符作为起点，往后统计。时间复杂度 O(N^2)
      // mask第 idx 位从 0 -> 1，表示对应字符出现了，但是未达到k次
      // mask第 idx 位从 1 -> 0，表示对应字符已经出现了k次
      // mask变成 0，表示这段子串满足要求

      class Solution
      {
      public:
          int longestSubstring(string s, int k)
          {
              int ans = 0;
              int start = 0;
              while(start + k <= s.size())
              {
                  int hash[26] = {0};
                  int mask = 0;
                  int next_start = start + 1;
                  for(int end = start; end < s.size(); ++end)
                  {
                      int idx = s[end] - 'a';
                      ++hash[idx];
                      if(hash[idx] < k) mask |= (1 << idx); // 0 -> 1
                      else mask &= ~(1 << idx);             // 1 -> 0
                      if(mask == 0)
                      {
                          ans = max(ans, end - start + 1);
                          next_start = end + 1;
                      }
                  }
                  start = next_start;
              }
              return ans;
          }
      };


几个数的和
---------------------------------------------------------------------------------------------------------------------------------------------

- [LeetCode] Two Sum 两数之和为目标值。Hint：哈希，时间复杂度 :math:`\mathcal{O}(N)` 。

  https://leetcode.com/problems/two-sum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          vector<int> twoSum(vector<int>& nums, int target)
          {
              vector<int> res;
              map<int, int> hash;
              for(size_t k = 0; k < nums.size(); k++) hash[nums[k]] = k;
              for(size_t k = 0; k < nums.size(); k++)
              {
                  if(hash.find(target - nums[k]) != hash.end())
                  {
                      if(hash[target - nums[k]] > k) // 避免重复统计同一对
                      {
                          res.push_back(k);
                          res.push_back(hash[target - nums[k]]);
                      }
                  }
              }
              return res;
          }
      };

- [LeetCode] 3Sum 3 个数之和为 0。Hint：先排序；双指针；时间复杂度 :math:`\mathcal{O}(N^2)` 。

  https://leetcode.com/problems/3sum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          vector<vector<int>> threeSum(vector<int>& nums)
          {
              vector<vector<int>> result;
              if(nums.size()<3) return result;
              sort(nums.begin(), nums.end());
              unsigned int n = nums.size();
              int target = 0;
              for(unsigned int i = 0; i + 2 < n; ++i)
              {
                  if(i > 0 && nums[i] == nums[i-1]) continue; // 忽略重复值
                  if(nums[i] + nums[i+1] + nums[i+2] > target) break; // 下界
                  if(nums[i] + nums[n-2] + nums[n-1] < target) continue; // 上界
                  unsigned int left = i + 1;
                  unsigned int right = n - 1;
                  while(left < right)
                  {
                      if(nums[i]+nums[left]+nums[right] == target)
                      {
                          result.push_back(vector<int>{nums[i], nums[left], nums[right]});
                          // 找到之后，两个指针都需要移动，并忽略重复值
                          do{++left;}while(nums[left] == nums[left-1] && left < right);
                          do{--right;}while(nums[right] == nums[right+1] && left < right);
                      }
                      else if(nums[i]+nums[left]+nums[right] < target)
                      {
                          do{++left;}while(nums[left] == nums[left-1] && left < right);
                      }
                      else
                      {
                          do{--right;}while(nums[right] == nums[right+1] && left < right);
                      }
                  }
              }
              return result;
          }
      };

- [LeetCode] 4Sum 4 个数之和为目标值。Hint：先排序；双指针；时间复杂度 :math:`\mathcal{O}(N^3)` 。

  https://leetcode.com/problems/4sum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          vector<vector<int>> fourSum(vector<int>& nums, int target)
          {
              vector<vector<int>> quad;
              if(nums.size() < 4) return quad;
              unsigned int n = nums.size();
              sort(nums.begin(), nums.end());
              for(unsigned int i = 0; i + 3 < n; ++i)
              {
                  if(i > 0 && nums[i] == nums[i-1]) continue; // 忽略重复值
                  if(nums[i] + nums[i+1] + nums[i+2] + nums[i+3] > target) break; // 下界
                  if(nums[i] + nums[n-3] + nums[n-2] + nums[n-1] < target) continue; // 上界
                  for(unsigned int j = i + 1; j + 2 < n; ++j)
                  {
                      if(j > i + 1 && nums[j] == nums[j-1]) continue; // 忽略重复值
                      if(nums[i] + nums[j] + nums[j+1] + nums[j+2] > target) break; // 下界
                      if(nums[i] + nums[j] + nums[n-2] + nums[n-1] < target) continue; // 上界
                      unsigned int left = j + 1;
                      unsigned int right = n - 1;
                      while(left < right)
                      {
                          int sum = nums[i] + nums[j] + nums[left] + nums[right];
                          if(sum == target)
                          {
                              quad.push_back(vector<int>{nums[i], nums[j], nums[left], nums[right]});
                              // 找到之后，两个指针都需要移动，并忽略重复值
                              do
                              {
                                  ++left;
                              }
                              while(nums[left] == nums[left-1] && left < right);
                              do
                              {
                                  --right;
                              }
                              while(nums[right] == nums[right+1] && left < right);
                          }
                          else if(sum < target)
                          {
                              do
                              {
                                  ++left;
                              }
                              while(nums[left] == nums[left-1] && left < right);
                          }
                          else
                          {
                              do
                              {
                                  --right;
                              }
                              while(nums[right] == nums[right+1] && left < right);
                          }
                      }
                  }
              }
              return quad;
          }
      };

- [LeetCode] 4Sum II 4 个数和为 0 的组合数。Hint：两两之和存入哈希表，时间复杂度和空间复杂度 :math:`\mathcal{O}(N^2)` 。

  https://leetcode.com/problems/4sum-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      def fourSumCount(self, A, B, C, D):
          AB = collections.Counter(a+b for a in A for b in B)
          return sum(AB[-c-d] for c in C for d in D)



[LeetCode] Maximum Product Subarray 求连续子数组的最大乘积
---------------------------------------------------------------------------------------------------------------------------------------------

Hint：数组中存在负数，负负得正，因此相比于连续子数组最大和问题，不仅需要记录以每个元素结尾的连续乘积的最大值，还需要记录最小值。

https://leetcode.com/problems/maximum-product-subarray/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxProduct(vector<int>& nums)
          {
              int pre_min = nums[0];
              int pre_max = nums[0];
              int curr_min = nums[0];
              int curr_max = nums[0];
              int maxproduct = nums[0];
              for(int k = 1; k < nums.size(); ++k)
              {
                  curr_min = min(nums[k], min(pre_min*nums[k], pre_max*nums[k]));
                  curr_max = max(nums[k], max(pre_min*nums[k], pre_max*nums[k]));
                  maxproduct = max(maxproduct, curr_max);
                  pre_min = curr_min;
                  pre_max = curr_max;
              }
              return maxproduct;
          }
      };

统计 1 的数目
---------------------------------------------------------------------------------------------------------------------------------------------

给定一个十进制整数 :math:`N` ，统计从 :math:`1` 到 :math:`N` 所有的整数各位出现的 :math:`1` 的数目。Hint： :math:`1` 的数目 = 个位出现 :math:`1` 的数目 + 十位出现 :math:`1` 的数目 + 百位出现 :math:`1` 的数目  + ......。以百位为例：如果百位数字为0，则百位出现1的次数只由更高位决定，如12013，次数为12 * 100；如果百位数字为1，则百位出现1的次数由更高位和更低位同时决定，如12113，次数为12 * 100 + (13 + 1)；如果百位数字大于1，则百位出现1的次数只由更高位决定，如12213，次数为(12 + 1) * 100。时间复杂度 :math:`\mathcal{O}(\log_{10}(N))` 。

https://leetcode.com/problems/number-of-digit-one

http://www.cnblogs.com/jy02414216/archive/2011/03/09/1977724.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      typedef unsigned long long Ull;
      class Solution
      {
      public:
          int countDigitOne(int n)
          {
              Ull factor = 1;
              Ull low, curr, high;
              Ull res = 0;
              while(n / factor)
              {
                  low = n % factor;
                  curr = (n / factor) % 10;
                  high = n / (factor * 10);
                  switch(curr)
                  {
                      case 0:
                          res += high * factor;
                          break;
                      case 1:
                          res += high * factor + low + 1;
                          break;
                      default:
                          res += (high + 1) * factor;
                  }
                  factor *= 10;
              }
              return res;
          }
      };


数组循环移位
---------------------------------------------------------------------------------------------------------------------------------------------

循环右移 :math:`K` 位，时间复杂度 :math:`\mathcal{O}(N)` 。Hint：三次翻转。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      void reverse(int *arr, int begin, int end)
      {
          for(; begin < end; begin++, end--) swap(arr[begin], arr[end]);
      }

      void right_shift(int *arr, int N, int K)
      {
          K %= N;
          reverse(arr, 0, N-K-1);
          reverse(arr, N-K, N-1);
          reverse(arr, 0, N-1);
      }




[LeetCode] Divide Two Integers 整数除法
---------------------------------------------------------------------------------------------------------------------------------------------

Hint：先取绝对值，做正整数之间的除法；防止溢出。

https://leetcode.com/problems/divide-two-integers/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int divide(int dividend, int divisor)
          {
              if(dividend == INT_MIN && divisor == -1) return INT_MAX; // 越界则输出最大值
              if(dividend == INT_MIN && divisor == 1) return INT_MIN;
              if(dividend == INT_MIN && divisor == INT_MIN) return 1; // 枚举分子为最小整数时的情形
              if(divisor == INT_MIN) return 0;

              bool sign = (dividend>0) ^ (divisor>0) ? false : true;

              int res = 0;

              bool max_flow = false;
              if(dividend == INT_MIN)
              {
                  dividend = abs(1 + INT_MIN); // 防止取绝对值之后溢出
                  max_flow = true;
              }
              else dividend = abs(dividend);
              divisor = abs(divisor);

              while(dividend >= divisor)
              {
                  int diff = divisor;
                  int n = 1;
                  while(diff <= (dividend >> 1))
                  {
                      diff <<= 1;
                      n <<= 1;
                  }
                  dividend -= diff;
                  res += n;
              }
              if(max_flow && dividend == divisor-1) res += 1;

              return sign? res : -res;
          }
      };


[LeetCode] Fraction to Recurring Decimal 循环小数
---------------------------------------------------------------------------------------------------------------------------------------------

Hint：小数除法：余数乘以10再求余；如果余数出现重复，则说明是循环小数。

https://leetcode.com/problems/fraction-to-recurring-decimal/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          string fractionToDecimal(int numerator, int denominator)
          {
              if(numerator == 0 || denominator == 0) return "0";
              int sign_num = numerator > 0? 1:-1;
              int sign_den = denominator > 0? 1:-1;

              long long num = abs((long long)numerator);
              long long den = abs((long long)denominator);

              long long integer = num / den;
              long long rem = num % den;

              string int_part = to_string(integer);
              if(rem) int_part += ".";

              string frac_part = "";
              unordered_map<long long, int> mp;
              int idx = 0;

              while(rem)
              {
                  if(mp.find(rem) != mp.end()) // 余数重复
                  {
                      frac_part.insert(mp[rem], "(");
                      frac_part += ")";
                      break;
                  }
                  mp[rem] = idx++;
                  frac_part += to_string((10*rem) / den);
                  rem = (10*rem) % den;
              }

              string res = "";
              if(sign_num * sign_den < 0) res += "-";
              res += int_part + frac_part;
              return res;
          }
      };



旋转数组查找
---------------------------------------------------------------------------------------------------------------------------------------------

Hint：采用二分查找的思路。

- 二分查找

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // preliminary: binary search，时间复杂度 O(logN)
      template<class T>
      int binarySearch(T* arr, int n, const T& target)
      {
          if(arr == nullptr || n <= 0) return -1;
          int low = 0;
          int high = n - 1; // 查找区间： [0, n)
          while(low <= high)
          {
              int mid = low + (high - low) / 2; // mid = (low + high)/2 可能导致溢出
              if(arr[mid] == target) return mid;
              if(arr[mid] < target) low = mid + 1;
              else high = mid - 1;
          }
          return -1;
      }

    .. code-block:: cpp
      :linenos:

      // 浮点数二分，不存在区间取整，要求达到某个精度

      // 例：在区间 [low, high] 二分查找开方数

      #define eps 1e-5

      bool judge(double mid, double x)
      {
          return mid >= x / mid;
      }

      double search(double low, double high, double x)
      {
          while(high - low > eps)
          {
              double mid = low + (high - low) / 2;
              if(judge(mid, x)) high = mid;
              else low = mid;
          }
          return low + (high - low) / 2; // 此时 low 和 high 比较接近，取它们的均值作为最终结果
      }

    .. code-block:: python
      :linenos:

      ## 返回区间 [first, last) 内第一个不小于 target 的位置
      ## 如果所有数都小于 target，则返回 last
      def lower_bound(a, first, last, target):
          if first > last:
              return None
          while first < last: ## [first, last)不为空
              mid = first + (last - first) // 2
              if a[mid] < target:
                  first = mid + 1
              else:
                  last = mid
          return first  
          ## 返回 last 也行，因为 [first, last) 为空的时候它们相等

- 查找旋转数组最小值（含重复元素）

  https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一
      // 第一个指针总指向前面递增数组的元素
      // 第二个指针总指向后面递增数组的元素
      // 最终两个指针指向相邻元素：第一个指针指向前面递增数组的最后一个元素，第二个指针指向后面递增数组的第一个元素（也就是最小元素）
      template<class T>
      int findRotateMin(T* arr, int n)
      {
          if(arr == nullptr || n <= 0) return -1;
          int low = 0;
          int high = n - 1;
          while(arr[low] >= arr[high])
          {
              if(high - 1 == low) return high;

              int mid = low + (high - low) / 2;

              // 如果这三个元素相等，则在区间 [low, high] 内顺序查找
              if(arr[low] == arr[mid] && arr[mid] == arr[high]) return (min_element(arr + low, arr + high + 1) - arr);

              if(arr[mid] <= arr[high]) high = mid;
              else low = mid;
          }
          // 如果数组本身是有序的，即 arr[0] < arr[n-1]，则第一个元素就是最小值
          return 0;
      }


    .. code-block:: python
      :linenos:

      # 方法二
      # 每次比较 nums[mid] 与 nums[high]，如果两者相等，则 --high
      class Solution:
          def findMin(self, nums: List[int]) -> int:
              n = len(nums)
              low = 0
              high = n - 1
              while low < high:
                  mid = low + (high - low) // 2
                  if nums[mid] == nums[high]:
                      high -= 1
                  else:
                      if nums[mid] > nums[high]:
                          low = mid + 1
                      else:
                          high = mid
              return nums[low]

- 在旋转数组查找目标值（无重复元素）

  https://leetcode.com/problems/search-in-rotated-sorted-array/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 每次比较 nums[mid] 与 nums[high]
      class Solution
      {
      public:
          int search(vector<int>& nums, int target)
          {
              int n = nums.size();
              if(n == 0) return -1;
              int low = 0;
              int high = n - 1;
              while(low <= high)
              {
                  int mid = low + (high - low) / 2;
                  if(nums[mid] == target) return mid;

                  if(nums[mid] < nums[high]) // 注：只有当 low == high，才会出现： mid == high，nums[mid] == nums[high]
                  {
                      if(nums[mid] < target && target <= nums[high]) low = mid + 1;
                      else high = mid - 1;
                  }
                  else
                  {
                      if(nums[mid] > target && target >= nums[low]) high = mid - 1;
                      else low = mid + 1;
                  }
              }
              return -1;
          }
      };

- 在旋转数组查找目标值（含重复元素）

  https://leetcode.com/problems/search-in-rotated-sorted-array-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // https://www.cnblogs.com/grandyang/p/4325840.html
      // 相对于上例，需要增加一个判断：如果 nums[mid] 与 nums[high] 相等，则 --high
      class Solution
      {
      public:
          bool search(vector<int>& nums, int target)
          {
              int n = nums.size();
              if(n == 0) return false;
              int low = 0;
              int high = n - 1;
              while(low <= high)
              {
                  int mid = low + (high - low) / 2;
                  if(nums[mid] == target) return true;

                  if(nums[mid] == nums[high]) --high; // 增加这个判断。注：只有当 low == high，才会出现： mid == high 。

                  else if(nums[mid] < nums[high])
                  {
                      if(nums[mid] < target && target <= nums[high]) low = mid + 1;
                      else high = mid - 1;
                  }
                  else
                  {
                      if(nums[mid] > target && target >= nums[low]) high = mid - 1;
                      else low = mid + 1;
                  }
              }
              return false;
          }
      };

- 在旋转数组查找目标值（含重复元素，若存在多个目标值需返回最小的下标）

  https://leetcode.cn/problems/search-rotate-array-lcci

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def search(self, arr: List[int], target: int) -> int:
                n = len(arr)
                low, high = 0, n - 1
                while low <= high:
                    mid = (low + high) // 2
                    ## 最左侧找到直接返回
                    if arr[low] == target:
                        return low
                    ## 这里将右边界移到 mid
                    if arr[mid] == target:
                        high = mid
                    elif arr[mid] == arr[high]:
                        high -= 1
                    elif arr[mid] < arr[high]:
                        if arr[mid] < target <= arr[high]:
                            low = mid + 1
                        else:
                            high = mid - 1
                    else:
                        if arr[low] <= target < arr[mid]:
                            high = mid - 1
                        else:
                            low = mid + 1
                return -1

[LeetCode] Maximum Gap 最大间隔
--------------------------------------------------------------------------------------------

Hint：方法一，普通排序，逐个比较；方法二，桶排序。将 :math:`n` 个数放到 :math:`n+1` 个桶中，最小值放第一个桶，
最大值放最后一个桶，每个桶的大小为 :math:`\frac{max-min}{n}` 。根据鸽巢原理，至少存在一个桶为空。最大间隔必然出现在空桶两侧，且只与左侧桶的最大值、
右侧桶的最小值有关。（事实上，可以将 :math:`n` 个数放到 :math:`n` 个桶中，如果没有空桶，则刚好每个桶有且仅有一个数，最大间隔出现在相邻桶中；如果某个桶有2个数以上，
说明存在有空桶，最大间隔出现在非空的相邻桶中。总之，最大间隔不会出现在一个桶中。）

https://leetcode.com/problems/maximum-gap/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 建立 n 个桶
      class Solution
      {
      public:
          int maximumGap(vector<int>& nums)
          {
              size_t n = nums.size();
              if(n < 2) return 0;

              int MIN = *min_element(nums.begin(), nums.end());
              int MAX = *max_element(nums.begin(), nums.end());
              if(MIN == MAX) return 0;

              vector<vector<int>> bucket(n, vector<int>(2, 0)); // 大小为 n * 2
              for(size_t k = 0; k < n; ++k)
              {
                  bucket[k][0] = INT_MAX;
                  bucket[k][1] = INT_MIN;
              }


              double delta = (MAX - MIN) / double(n - 1);
              for(size_t k = 0; k < n; ++k)
              {
                  int idx = (nums[k] - MIN) / delta;
                  bucket[idx][0] = min(nums[k], bucket[idx][0]);
                  bucket[idx][1] = max(nums[k], bucket[idx][1]);
              }

              int gap = 0;
              size_t pre = 0;
              size_t curr = 1;
              while(curr < bucket.size())
              {
                  if(bucket[curr][0] == INT_MAX && bucket[curr][1] == INT_MIN) curr++; // 空桶
                  else
                  {
                      if(curr - pre >= 1)
                      {
                          int pre_max = bucket[pre][1];
                          int curr_min = bucket[curr][0];
                          gap = max(gap, curr_min - pre_max);
                      }
                      pre = curr;
                      curr++;
                  }
              }
              return gap;
          }
      };



数组操作模拟大数乘法
--------------------------------------------------------------------------------------------

Hint：从低位到高位，采用竖式计算，记录所有位的乘积，再将对应位的结果相加，最后进位。假设数组 :math:`a` 和 :math:`b` 从低位到高位存储了两个大数（可能存在小数点），则乘积为 :math:`\mathrm{ans}[k] = \sum_{i+j=k}  a[i] \times b[j]` 。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      def preProcess(a):
          ## input: str
          ## output: list, l
          pf = a.find('.')
          lf = 0
          if pf != -1:
              lf = len(a) - 1 - pf ## 小数位数
              a = a[:pf] + a[pf+1:] ## 去掉小数点
          a = list(a)
          a = a[::-1] ## 翻转数组，a[0] 表示最低位
          return a, lf

      def strMul(a, b):
          a, la = preProcess(a)
          b, lb = preProcess(b)
          lf = la + lb

          ans = [0 for _ in range(len(a) + len(b))]
          for ia in range(len(a)):
              for ib in range(len(b)):
                  ans[ia+ib] += int(a[ia]) * int(b[ib])
          carry = 0
          for i in range(len(ans)):
              tmp = ans[i] + carry
              ans[i] = tmp % 10
              carry = tmp / 10
          ans = ans[::-1] ## 翻转数组

          if lf > 0:
              ans.insert(len(ans) - lf, '.') ## 插入小数点
          if ans[0] == 0:
              ans = ans[1:] ## 最高位是 0 则去掉
          iz = len(ans)-1
          while lf > 0 and ans[iz] == 0: ## 去掉小数点末尾的 0
              iz -= 1

          s = ''
          for e in ans[:iz+1]:
              s += str(e)

          return s


[LeetCode] Number of Islands 孤岛个数
--------------------------------------------------------------------------------------------

Hint：使用队列，广度优先遍历（BFS）。

延伸：从坐标 :math:`(0, 0)` 到 :math:`(n-1, m-1)` 的最短时间，只能走四邻域，:math:`\mathrm{map}[i][j] = 1` 表示有障碍。Hint：BFS，第一个到达的就是时间最短的。

https://leetcode.com/problems/number-of-islands/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        // 孤岛个数
        class Solution
        {
        public:
            void traverseIsland(vector<vector<char>>& grid, int m, int n, const int M, const int N)
            {
                queue<pair<int, int>> que;

                que.push(make_pair(m, n));
                grid[m][n] = '0';

                while (!que.empty())
                {
                    pair<int, int> p = que.front();
                    que.pop();

                    for (int i = 0; i < 4; ++i)
                    {
                        int next_x = p.first + directions[i][0];
                        int next_y = p.second + directions[i][1];
                        if (0 <= next_x && next_x < M && 0 <= next_y && next_y < N && grid[next_x][next_y] == '1')
                        {
                            // 入队需要改变标志位，避免后续过程中同一坐标重复入队
                            grid[next_x][next_y] = '0';
                            que.push(make_pair(next_x, next_y));
                        }
                    }
                }
            }

            int numIslands(vector<vector<char>>& grid)
            {
                if (grid.size()==0) return 0;
                int M = grid.size();
                int N = grid[0].size();
                int island = 0;
                for (int m = 0; m < M; ++m)
                {
                    for (int n = 0; n < N; ++n)
                    {
                        if (grid[m][n]=='1')
                        {
                            island += 1;
                            traverseIsland(grid, m, n, M, N);
                        }
                    }
                }
                return island;
            }
        private:
            static const int directions[4][2];
        };

        const int Solution::directions[4][2] = {{-1,0},{0,-1},{1,0},{0,1}};

    .. code-block:: cpp
        :linenos:

        // 最短时间
        // https://www.nowcoder.com/practice/365493766c514d0da0cd774d3d40fd49?tpId=8&tqId=11040&tPage=1&rp=1&ru=/ta/cracking-the-coding-interview&qru=/ta/cracking-the-coding-interview/question-ranking
        // https://leetcode.com/problems/shortest-path-in-binary-matrix/

        struct point
        {
            int x;
            int y;
            int time;
            point(int _x, int _y, int _time): x(_x), y(_y), time(_time){}
        };

        class Solution
        {
        public:
            int shortestPathBinaryMatrix(vector<vector<int>>& grid)
            {
                int n = grid.size();
                queue<point> q;
                if(grid[0][0] != 1)
                {
                    q.push(point(0, 0, 1));
                    grid[0][0] = 1;
                }
                while(!q.empty())
                {
                    auto p = q.front();
                    q.pop();
                    if(p.x == n-1 && p.y == n-1) return p.time;
                    for(int i = 0; i < 8; ++i)
                    {
                        int next_x = p.x + directions[i][0];
                        int next_y = p.y + directions[i][1];
                        if(0 <= next_x && next_x < n && 0 <= next_y && next_y < n && grid[next_x][next_y] != 1)
                        {
                            // 入队需要改变标志位，避免后续过程中同一坐标重复入队
                            grid[next_x][next_y] = 1;
                            q.push(point(next_x, next_y, p.time+1));
                        }
                    }
                }
                return -1;
            }
        private:
            static const int directions[8][2];
        };

        const int Solution::directions[8][2] = {
            {-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}
        };

        // 注意：当点 p 的近邻都满足条件入队之后，它们的标志位全部同时改变
        // 因为当最短路径包含点 p 时，只会再包含点 p 的一个近邻，最短路径不可能多次经过点 p 的不同近邻

回文（Palindrome）
--------------------------------------------------------------------------------------------

- [LeetCode] Longest Palindromic Substring 最长回文子串（子串连续）。Hint：方法一，中心扩展法，回文中心的两侧互为镜像，将每一个位置作为中心进行扩展，回文分偶数和奇数；方法二，动态规划，类似于矩阵连乘问题，逐渐增大步长。

  https://leetcode.com/problems/longest-palindromic-substring/

  .. math::
      :nowrap:

      $$
      dp[i][i] = \mathrm{true}
      $$

      $$
      dp[i][j] =
      \begin{cases}
      \mathrm{true} & &\ s[i] = s[j]\ \&\&\ (i \leqslant j \leqslant i+1\ ||\ dp[i+1][j-1] = \mathrm{true}) \\
      \mathrm{false} & &\ \mathrm{otherwise}
      \end{cases}
      $$


  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        // 方法一，中心扩展法
        class Solution {
        public:
            void palindrome(int i, int j, string s, int& start, int& longest)
            {
                while(i >= 0 && j < s.size() && s.at(i) == s.at(j))
                {
                    i--;
                    j++;
                }
                i += 1;
                j -= 1;
                if(j - i + 1 > longest)
                {
                    longest = j-i+1;
                    start = i;
                }
            }
            string longestPalindrome(string s) {
                int len = s.size();
                if(len <= 1) return s;
                int start = 0;
                int longest = 1;
                for(int i = 0; i < len-1; ++i)
                {
                    palindrome(i, i, s, start, longest);
                    palindrome(i, i+1, s, start, longest);
                }
                string str;
                str.assign(s, start, longest);
                return str;
            }
        };

    .. code-block:: cpp
       :linenos:

       // 方法二，动态规划
       class Solution
       {
       public:
           string longestPalindrome(string s)
           {
               if(s.size() <= 1) return s;
               size_t len = s.size();
               vector<vector<bool>> dp(len, vector<bool>(len, false));
               size_t start = 0;
               size_t longest = 1;
               for(size_t i = 0; i < len; ++i) dp[i][i] = true;
               for(size_t gap = 0; gap < len; ++gap)
               {
                   for(int i = 0; i + gap < len; ++i)
                   {
                       int j = i + gap;
                       if(s[i] == s[j])
                       {
                           if(gap <= 1 || dp[i+1][j-1])
                           {
                               dp[i][j] = true;
                               longest = j - i + 1; // 由于步长是逐渐增大的，因此最后得到的回文子串一定是最长的
                               start = i;
                           }
                           else dp[i][j] = false;
                       }
                   }
               }
               vector<vector<bool>>().swap(dp);
               return s.substr(start, longest);
           }
       };

- [LeetCode] Longest Palindromic Subsequence 最长回文子序列（子序列可以不连续）。Hint：寻找原字符串与翻转字符串的最长公共子序列，动态规划。

  https://leetcode.com/problems/longest-palindromic-subsequence/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        class Solution
        {
        public:
            // 寻找字符串 str 与其翻转字符串的最长公共子序列
            int lcsLength(string& str)
            {
                int len = str.size();
                vector<vector<int>> dp(len+1, vector<int>(len+1, 0));
                // dp[i][j] 表示前 i 个字符和后 j 个字符翻转后的最长公共子序列的长度
                for(int i = 1; i <= len; ++i)
                {
                    for(int j = 1; j <= len; ++j)
                    {
                        if(str[i-1] == str[len-j]) dp[i][j] = dp[i-1][j-1] + 1;
                        else dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
                    }
                }
                int ans = dp[len][len];
                vector<vector<int>>().swap(dp);
                return ans;
            }

            int longestPalindromeSubseq(string s)
            {
                if(s.size() <= 1) return s.size();
                return lcsLength(s);
            }
        };

- [LeetCode] Count Different Palindromic Subsequences 统计不同回文子序列的个数（子序列可以不连续）。

  https://leetcode.com/problems/count-different-palindromic-subsequences/

  https://leetcode.com/problems/count-different-palindromic-subsequences/discuss/272297/DP-C%2B%2B-Clear-solution-explained

  https://blog.csdn.net/lili0710432/article/details/78659583

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Analysis}`

    用 :math:`dp[i][j]` 表示字符串 :math:`[i,j]` 区间内的的回文子序列个数。

      - :math:`S[i] \ne S[j]` 。下式的第三项是前两项重复计算的部分。

        .. math::

          dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1]

      - :math:`S[i] = S[j]`

        - 如果相同的回文子序列可以多次统计，递推式如下。其中 :math:`+1` 统计的是长度为 2 的回文子序列 “ :math:`S[i]S[j]` ”；
          :math:`+ dp[i+1][j-1]` 统计的是以 “ :math:`S[i]` ”开头，以 “ :math:`S[j]` ”结尾，且中间部分取自区间 :math:`[i+1,j-1]` 的回文子序列。

          .. math::

            dp[i][j] &=\ dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1] + 1 + dp[i+1][j-1] \\
                     &=\ dp[i+1][j] + dp[i][j-1] + 1

        - 如果只统计不同回文子序列的个数，分三种情况。

            - 若 :math:`S[i]` 不再出现在区间 :math:`[i+1,j-1]` 内，递推式如下。其中 :math:`\times 2` 统计了两类回文子序列：一类是以 “ :math:`S[i]` ”开头，以 “ :math:`S[j]` ”结尾，且中间部分取自区间 :math:`[i+1,j-1]` 的回文子序列，另一类是只取自区间 :math:`[i+1,j-1]` 的回文子序列；
              :math:`+2` 统计的是长度为 1 的回文子序列 “ :math:`S[i]` ”和长度为 2 的回文子序列 “ :math:`S[i]S[j]` ”。

              .. math::

                dp[i][j] = dp[i+1][j-1] \times 2 + 2

            - 若 :math:`S[i]` 在区间 :math:`[i+1,j-1]` 内又出现 1 次，递推式如下。 :math:`+1` 统计的是长度为 2 的回文子序列 “ :math:`S[i]S[j]` ”，长度为 1 的回文子序列 “ :math:`S[i]` ”在区间 :math:`[i+1,j-1]` 内已经统计过了。

              .. math::

                dp[i][j] = dp[i+1][j-1] \times 2 + 1

            - 若 :math:`S[i]` 在区间 :math:`[i+1,j-1]` 内又出现多次，设出现的第一个位置是 :math:`l` ，最后一个位置是 :math:`r` ，递推式如下。这种情况下，以 “ :math:`S[i]` ”开头，以 “ :math:`S[j]` ”结尾，且中间部分取自区间 :math:`[i+1,j-1]` 的回文子序列也会被重复统计。

              .. math::

                dp[i][j] = dp[i+1][j-1] \times 2 - dp[l+1][r-1]

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int countPalindromicSubsequences(string S)
          {
              int n = S.size();
              if(n <= 1) return n;
              vector<vector<long long>> dp(n, vector<long long>(n, 0)); // long long 防止溢出
              for(int i = 0; i < n; ++i) dp[i][i] = 1;

              long long modulo = 1000000007;
              for(int gap = 1; gap < n; ++gap)
              {
                  for(int i = 0; i + gap < n; ++i)
                  {
                      int j = i + gap;
                      if(S[i] != S[j])
                      {
                          dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1];
                      }
                      else
                      {
                          dp[i][j] = dp[i+1][j-1] * 2; // 先计算这部分，避免后面重复计算
                          int left = i + 1;
                          int right = j - 1;
                          while(left < j && S[left] != S[i]) left++;
                          while(right > i && S[right] != S[i]) right--;

                          if(left > right) dp[i][j] += 2;
                          else if(left == right) dp[i][j] += 1;
                          else dp[i][j] -= dp[left+1][right-1];
                      }
                      dp[i][j] = (dp[i][j] + modulo) % modulo; // 前面有减法操作，因此 dp[i][j] 可能是负数
                  }
              }

              int res = dp[0][n-1];
              dp.clear();
              dp.shrink_to_fit();
              return res;
          }
      };

- [LeetCode] Palindrome Partitioning 分割字符串使所有的子串都是回文子串。Hint：回溯，从字符串起始位置往后判断回文，如果满足回文，加入子串集合，并从回文结束位置往后遍历。

  https://leetcode.com/problems/palindrome-partitioning/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          vector<vector<string>> partition(string s)
          {
              vector<vector<string>> res;
              if(s.empty()) return res;

              // isPalindrome[i][j] 表示 s 的区间 [i,j] 是否是回文
              vector<vector<bool>> isPalindrome(s.size(), vector<bool>(s.size(), false));
              for(int gap = 0; gap < s.size(); ++gap)
              {
                  for(int i = 0; i+gap < s.size(); ++i)
                  {
                      int j = i + gap;
                      if(s[i] == s[j])
                      {
                          if(gap <= 1) isPalindrome[i][j] = true;
                          else isPalindrome[i][j] = isPalindrome[i+1][j-1];
                      }
                      else isPalindrome[i][j] = false;
                  }
              }

              vector<string> tmp;
              dfs(s, 0, tmp, res, isPalindrome);

              isPalindrome.clear();
              isPalindrome.shrink_to_fit();

              return res;
          }
      private:
          void dfs(string& s, int t, vector<string>& tmp, vector<vector<string>>& res, vector<vector<bool>>& isPalindrome)
          {
              if(t == s.size())
              {
                  res.push_back(tmp);
                  return;
              }
              for(int i = t; i < s.size(); ++i)
              {
                  if(isPalindrome[t][i])
                  {
                      tmp.push_back(s.substr(t, i-t+1)); // 如果满足回文，加入当前子串集合
                      dfs(s, i+1, tmp, res, isPalindrome); // 回文结束位置为 i，因此下一个起始位置是 i+1
                      tmp.pop_back();
                  }
              }
          }
      };

- [LeetCode] Palindrome Partitioning II 找出最短回文分割。Hint：如果采用上题方法，会超时；使用动态规划，类似于最长上升子序列的解法。

  https://leetcode.com/problems/palindrome-partitioning-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution {
      public:
          int minCut(string s) {
              if(s.size() <= 1) return 0;

              vector<vector<bool>> isPalindrome(s.size(), vector<bool>(s.size(), false));
              for(int gap = 0; gap < s.size(); ++gap)
              {
                  for(int i = 0; i+gap < s.size(); ++i)
                  {
                      int j = i + gap;
                      if(s[i] == s[j])
                      {
                          if(gap <= 1) isPalindrome[i][j] = true;
                          else isPalindrome[i][j] = isPalindrome[i+1][j-1];
                      }
                      else isPalindrome[i][j] = false;
                  }
              }

              vector<int> dp(s.size(), 0); // dp[i] 表示区间 [0, i] 的最短回文分割
              for(int i = 1; i < s.size(); ++i)
              {
                  if(isPalindrome[0][i]) dp[i] = 0;
                  else
                  {
                      dp[i] = dp[i-1] + 1; // 直接划分 s[i] 为一个子串
                      for(int j = 1; j < i; ++j)
                      {
                          if(isPalindrome[j][i]) dp[i] = min(dp[i], dp[j-1] + 1); // [j, i] 为一个子串
                      }
                  }
              }

              int res = dp[s.size()-1];

              isPalindrome.clear(); isPalindrome.shrink_to_fit();
              dp.clear(); dp.shrink_to_fit();

              return res;
          }

      };

判断字符串 s2 是否可由 s1 旋转得到
--------------------------------------------------------------------------------------------

Hint：对 s1 做循环移位，所得字符串都将是字符串 s1s1 的子串。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      bool checkReverseEqual(string s1, string s2)
      {
          if(s1.size()==0 || s2.size()==0) return false;
          if(s1.size() < s2.size()) return false; // s1 = "abc", s2 = "abcabc"
          string s1s1 = s1 + s1;
          if(s1s1.find(s2) == string::npos) return false;
          return true;
      }

[LeetCode] Validate Binary Search Tree 检查一棵二叉树是否为二叉查找树
--------------------------------------------------------------------------------------------

Hint：不仅要求左节点比当前节点小，右节点比当前节点大，而是要求左子树所有节点都小于当前节点，右子树所有节点都大于当前节点；利用二叉树的中序遍历，BST 得到的序列是升序排列的。

https://leetcode.com/problems/validate-binary-search-tree/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          bool isValidBST(TreeNode* root)
          {
              // 节点的值 val 是 int 型
              long long pre = (long long)(INT_MIN) - 1;
              return checkBST(root, pre);
          }
      private:
          // 中序遍历，检查上一个遍历的数是否小于当前数, O(1) 空间复杂度
          bool checkBST(TreeNode* root, long long& pre)
          {
              if(!root) return true;
              if(!checkBST(root->left, pre)) return false;
              if(pre >= (long long)(root->val)) return false;
              pre = (long long)(root->val);
              return checkBST(root->right, pre);
          }
      };

判断一个数是否是奇数
--------------------------------------------------------------------------------------------

Hint：考虑负数的情形；方法一，判断模 2 结果不为 0；方法二，位运算判断最低位为 1。

延伸：判断两个数是否相等（或判断某个数是否为 0），
如果是浮点数，应该判断两者差的绝对值是否小于一个阈值，而不是直接使用 ==。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      bool isOdd1(int x)
      {
          return (x % 2) != 0;
      }

      bool isOdd2(int x)
      {
          return (x & 1) == 1;
      }

      bool isEqual(double x, double y)
      {
          return fabs(x - y) < 1e-6;
      }


延伸：检查一个数是否是 2 的整次幂，Hint：二进制表示只有一个 1；检查一个数是否是 4 的整次幂，Hint：4 的整次幂的二进制表示中，
1 都在奇数位；检查一个数是否是 3 的整次幂，Hint：质数的整次幂的质因子只有该质数本身。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 检查一个数是否是 2 的整次幂
      bool checkPower2(int n)
      {
        return n > 0 && (n & (n - 1)) == 0;
      }

    .. code-block:: cpp
      :linenos:

      // 检查一个数是否是 4 的整次幂
      bool checkPower4(int n)
      {
        if(n > 0 && (n & (n - 1)) == 0) // 先确保是 2 的整次幂（只有一个 1）
        {
          if((n & 0x55555555) == n) return true; // 0x55555555 = 0101 0101 0101 0101 0101 0101 0101 0101
        }
        return false;
      }

    .. code-block:: cpp
      :linenos:

      // 检查一个数是否是 3 的整次幂
      bool checkPower3(int n)
      {
        return n > 0 && 1162261467 % n == 0; // 3^19 = 1162261467 是 int 型中最大的 3 的整次幂
      }


[LeetCode] Valid Number 验证一个字符串是否表示某个有效数字
--------------------------------------------------------------------------------------------

Hint：完整的数字表达是“空格+正负号+整数+小数点+整数+e+正负号+整数+空格”；小数点的相邻两边至少要有一边是整数；如果出现 e，其两边都必须出现整数，但不要求相邻；如 05.e-3 是一个有效数字。

延伸：将字符串转换为整数，需要考虑：空串、正负号、无效字符、溢出。

https://leetcode.com/problems/valid-number/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 验证一个字符串是否表示某个有效数字
      class Solution
      {
      public:
          bool isNumber(string s)
          {
              size_t idx = 0;
              bool hasDigit = false;

              scanSpace(s, idx);
              scanSign(s, idx);
              hasDigit = scanDigit(s, idx);
              scanPoint(s, idx);
              hasDigit |= scanDigit(s, idx);
              if(hasDigit) // 小数点的相邻两边至少要有一边是整数；e 的左边必须出现整数；如果既没有小数点，又没有 e，则要求该字符串中必须包含整数。总而言之，这里必须是 true 才有可能是有效数字
              {
                  if(scanExp(s, idx))
                  {
                      scanSign(s, idx);
                      hasDigit = scanDigit(s, idx); // e 的右边必须出现整数
                  }
                  scanSpace(s, idx);
                  if(idx == s.size() && hasDigit) return true;
              }
              return false;
          }
      private:
          void scanSpace(string& s, size_t& idx)
          {
              while(idx < s.size() && s.at(idx) == ' ') ++idx;
          }
          void scanSign(string& s, size_t& idx)
          {
              if(idx < s.size() && (s.at(idx) == '+' || s.at(idx) == '-')) ++idx;
          }
          bool scanDigit(string& s, size_t& idx)
          {
              if(idx >= s.size()) return false;
              if(s.at(idx) < '0' || s.at(idx) > '9') return false;
              while(idx < s.size() && '0' <= s.at(idx) && s.at(idx) <= '9') ++idx;
              return true;
          }
          void scanPoint(string& s, size_t& idx)
          {
              if(idx < s.size() && s.at(idx) == '.') ++idx;
          }
          bool scanExp(string& s, size_t& idx)
          {
              if(idx < s.size() && s.at(idx) == 'e')
              {
                  ++idx;
                  return true;
              }
              return false;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 将字符串转换为整数
      class Solution
      {
      public:
          int myAtoi(string str)
          {
              unsigned int idx = 0;
              scanSpace(str, idx);

              bool sign = true;
              if(idx < str.size() && str[idx] == '-' || str[idx] == '+')
              {
                  if(str[idx] == '-') sign = false;
                  ++idx;
              }

              long long ans = 0;
              bool hasDigit = false;
              while(idx < str.size() && '0' <= str[idx] && str[idx] <= '9')
              {
                  hasDigit = true;
                  ans = 10 * ans + str[idx] - '0';
                  if(sign && ans > INT_MAX)
                  {
                      validInt = false;
                      return INT_MAX;
                  }
                  if(!sign && -ans < INT_MIN)
                  {
                      validInt = false;
                      return INT_MIN;
                  }
                  ++idx;
              }
              scanSpace(str, idx);
              if(idx == str.size() && hasDigit)
              {
                  if(!sign) ans = - ans;
                  validInt = true;
                  return static_cast<int>(ans);
              }

              validInt = false;
              return 0;
          }
      private:
          bool validInt; // 标志符，输出 0 / INT_MAX / INT_MIN 时，有可能是异常情形
          void scanSpace(string str, unsigned int& idx) // 扫描首尾空格
          {
              while(idx < str.size() && str[idx] == ' ') ++idx;
          }
      };

求 :math:`1+2+3+ \cdots +n` ，不使用：乘除法，判断，循环，库函数。
--------------------------------------------------------------------------------------------

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一，构造函数
      class A
      {
      public:
          A()
          {
              id++;
              sum += id;
          }
          static void reset()
          {
              id = 0;
              sum = 0;
          }
          static unsigned int getSum()
          {
              return sum;
          }
      private:
          static unsigned int id;
          static unsigned int sum;
      };

      unsigned int A::id = 0;
      unsigned int A::sum = 0;

      unsigned int sumFrom1ToN(unsigned int N)
      {
          A::reset();

          A* arr = new A[N];
          delete[] arr;

          return A::getSum();
      }

    .. code-block:: cpp
      :linenos:

      // 方法二，虚函数

      class A; // 前向声明
      A* arr[2]; // 这里可以声明类 A 的指针，但是不能声明类 A 的变量，类 A 还未定义

      class A
      {
      public:
          virtual unsigned int getSum(unsigned int n)
          {
              return 0;
          }
      };

      class B: public A
      {
      public:
          unsigned int getSum(unsigned int n) override
          {
              return n + arr[!!n] -> getSum(n - 1); // !!n：当 n>0，arr[1] 调用 B::getSum(n)；当 n=0，arr[0] 调用 A::getSum(n)
          }
      };

      unsigned int sumFrom1ToN(unsigned int N)
      {
          A a;
          B b;
          arr[0] = &a;
          arr[1] = &b;
          return arr[1] -> getSum(N);
      }

[LeetCode] Lexicographical Numbers 按字典序排列 :math:`1 \sim n` 
--------------------------------------------------------------------------------------------

Hint：方法一，定义排序规则，按字符串的字典序排序；方法二，回溯，递归深度只与 :math:`n` 的位数有关。

https://leetcode.com/problems/lexicographical-numbers/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一，定义排序规则

      class Solution
      {
      public:
          vector<int> lexicalOrder(int n)
          {
              vector<int> res;
              if(n < 1) return res;
              res.resize(n);
              iota(res.begin(), res.end(), 1);
              sort(res.begin(), res.end(), comparator);
              return res;
          }
      private:
          static bool comparator(int x, int y)
          {
              return strcmp(to_string(x).c_str(), to_string(y).c_str()) < 0 ? true: false;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 方法二，回溯，从高位往低位进行

      class Solution
      {
      public:
          vector<int> lexicalOrder(int n)
          {
              vector<int> res;
              for(int high = 1; high <= 9; ++high) dfs(high, n, res); // 最高位不能为 0
              return res;
          }
      private:
          void dfs(int high, int n, vector<int>& res)
          {
              if(high > n) return;
              res.push_back(high); // 只有高位，没有低位。这是同一前缀的数字中最小的数
              for(int low = 0; low <= 9; ++low) dfs(high * 10 + low, n, res); // 高位 + 低位
          }
      };


延伸：找到字典序排列的第 :math:`k` 个数。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      ## 在字典树的区间 [p, p+1) 及其子区间查找
      ## 下一层子区间为 [p*10, (p+1)*10)
      ## 如果子区间内没找到，则进入兄弟区间 [p+1, p+2)

      def dictOrder(n, k):
          pos = 1
          while True:
              left = pos
              right = pos + 1
              cnt = 0
              while n >= left:
                  cnt += min(n+1, right) - left ## 区间大小
                  left *= 10
                  right *= 10
              if cnt < k:   ## 不在区间 [pos, pos+1) 及其子区间内
                  k -= cnt
                  pos += 1   ## 进入兄弟区间
              else:         ## 在区间 [pos, pos+1) 或其子区间内
                  k -= 1
                  if k == 0:
                      return pos
                  pos *= 10  ## 进入子区间

[LeetCode] Merge k Sorted Lists 合并 :math:`k` 条有序链表
--------------------------------------------------------------------------------------------

Hint：建立大小为 :math:`k` 的小顶堆，每次弹出一个节点，并把该节点的下一个节点插入小顶堆中。时间复杂度 :math:`\mathcal{O}(n \log k)` ，:math:`n` 是节点个数。

https://leetcode.com/problems/merge-k-sorted-lists/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      struct ListNode
      {
          int val;
          ListNode* next;
          ListNode(int x) : val(x), next(nullptr) {}
      };

      struct comparator
      {
          bool operator()(ListNode* a, ListNode* b)
          {
              return a->val > b->val; // 小顶堆
          }
      };

      class Solution
      {
      public:
          ListNode* mergeKLists(vector<ListNode*>& lists)
          {
              if(lists.size() == 0) return nullptr;
              if(lists.size() == 1) return lists[0];

              ListNode* head = new ListNode(0); // 合并链表的临时头节点

              priority_queue<ListNode*, vector<ListNode*>, comparator> pq;
              for(auto & list : lists)
              {
                  if(list) pq.emplace(list); // 建堆
              }
              ListNode* curr = head;
              while(!pq.empty())
              {
                  ListNode* p = pq.top();
                  pq.pop();
                  curr->next = p;
                  curr = p;
                  if(p->next) pq.push(p->next);
              }

              curr = head->next;
              delete head;
              return curr;
          }
      };


[LeetCode] Max Points on a Line 统计共线的最多点数
--------------------------------------------------------------------------------------------

Hint：直线需要考虑三种斜率：水平，垂直，斜线，还要考虑点重合的情形；由于浮点运算的精度问题，将斜率表示为两个整数的分数形式，保存到哈希表中。

https://leetcode.com/problems/max-points-on-a-line/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxPoints(vector<vector<int>>& points)
          {
              int res = 0;
              for(size_t i = 0; i < points.size(); ++i) // points.size() == 0，返回 0；points.size() == 1，返回 1
              {
                  unordered_map<string, int> mp; // 对每个点 i 统计其与其他点所成直线的斜率。由于这些直线都通过点 i，因此斜率相同就表示共线
                  int samePointNum = 0;
                  int verticalLineNum = 0;
                  int horizontalLineNum = 0;
                  int slantLineNum = 0;
                  for(size_t j = i + 1; j < points.size(); ++j) // 往后遍历每个点
                  {
                      if(points[i][0] == points[j][0] && points[i][1] == points[j][1]) ++samePointNum; // 点重合
                      else if(points[i][0] == points[j][0]) ++verticalLineNum; // 垂直线
                      else if(points[i][1] == points[j][1]) ++horizontalLineNum; // 水平线，可以计算斜率，但是由于垂直方向差异为 0，不好计算公约数
                      else // 斜线
                      {
                          int dx = points[j][0] - points[i][0];
                          int dy = points[j][1] - points[i][1];
                          int g = _gcd(dy, dx);
                          dx /= g;
                          dy /= g;
                          if(dy < 0) // 符号统一令 dy > 0
                          {
                              dy = -dy;
                              dx = -dx;
                          }
                          stringstream ss;
                          ss << dx << " " << dy;
                          string slope = ss.str();
                          ss.clear();
                          if(mp.find(slope) == mp.end()) mp[slope] = 1;
                          else ++mp[slope];
                          slantLineNum = max(slantLineNum, mp[slope]);
                      }
                  }

                  int currMax = max(slantLineNum, max(verticalLineNum, horizontalLineNum));
                  currMax += samePointNum + 1; // + 1 表示点 i 本身
                  res = max(res, currMax);
              }
              return res;
          }
      private:
          int _gcd(int a, int b) // 辗转相除，计算最大公约数
          {
              a = abs(a);
              b = abs(b);
              if(a < b) swap(a, b);
              while(a % b)
              {
                  int tmp = a;
                  a = b;
                  b = tmp % b;
              }
              return b;
          }
      };

[LeetCode] Word Break 字符串按字典切分
--------------------------------------------------------------------------------------------

Hint：回溯；动态规划；字典树/哈希表。

https://leetcode.com/problems/word-break


  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        // 方法一，回溯
        // 测试用例超时
        // "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab" ["a","aa","aaa","aaaa","aaaaa","aaaaaa","aaaaaaa","aaaaaaaa","aaaaaaaaa","aaaaaaaaaa"]

        #include <unordered_set>
        class Solution
        {
        public:
            bool wordBreak(string s, vector<string>& wordDict)
            {
                if(s == "") return true;
                if(wordDict.size() == 0) return false;
                unordered_set<string> wordSet(wordDict.begin(), wordDict.end());
                return wordFind(s, wordSet, 0);
            }
        private:
            bool wordFind(string& s, const unordered_set<string>& wordSet, int k)
            {
                if(k == s.size()) return true;
                for(int i = k; i < s.size(); ++i)
                {
                    if(wordSet.find(s.substr(k, i - k + 1)) != wordSet.end())
                    {
                        if(wordFind(s, wordSet, i + 1)) return true;
                    }
                }
                return false;
            }
        };


    .. code-block:: cpp
      :linenos:

      // 方法二，动态规划，空间复杂度 O(n^2)
      // dp[i][j] 表示字符串区间 [i, j] 的切分情况
      // 解法类似于矩阵连乘问题

      class Solution
      {
      public:
          bool wordBreak(string s, vector<string>& wordDict)
          {
              if(s.empty() || wordDict.empty()) return false;
              int n = s.size();
              vector<vector<bool>> dp(n, vector<bool>(n, false));
              for(int gap = 0; gap < n; ++gap)
              {
                  for(int i = 0; i + gap < n; ++i)
                  {
                      int j = i + gap;
                      for(string& word: wordDict)
                      {
                          // 这里用 ||，只要有一个 word 匹配就行
                          if(gap + 1 == word.size()) dp[i][j] = dp[i][j] || (s.substr(i, word.size()) == word);
                          else if(gap + 1 > word.size()) dp[i][j] = dp[i][j] || (s.substr(i, word.size()) == word && dp[i+word.size()][j]);
                      }
                  }
              }
              return dp[0][n-1];
          }
      };


    .. code-block:: cpp
        :linenos:

        // 方法三，动态规划，空间复杂度 O(n)
        // dp[i] 表示字符串区间 [0, i-1] 的切分情况

        #include <unordered_set>
        class Solution {
        public:
            bool wordBreak(string s, vector<string>& wordDict) {
                if(s.empty() || wordDict.empty()) return false;

                unordered_set<string> wordSet(wordDict.begin(), wordDict.end());

                int n = s.size();
                vector<bool> dp(n+1, false);
                dp[0] = true; // 初始化

                for(unsigned int i = 1; i <= n; ++i)
                {
                    for(unsigned int j = 0; j < i; ++j)
                    {
                        if(dp[j]) // 两段子串：[0, j-1], [j, i]
                        {
                            string str = s.substr(j, i-j);
                            if(wordSet.find(str) != wordSet.end())
                            {
                                dp[i] = true;
                                break;
                            }
                        }
                    }
                }
                return dp[n];
            }
        };

延伸：返回所有的切分方式。

https://leetcode.com/problems/word-break-ii

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`
      
    .. code-block:: python
        :linenos:

        ## 返回所有的切分方式
        ## 使用字典树 Trie

        from collections import defaultdict

        class TrieNode(object):
            def __init__(self):
                self.dict = defaultdict(TrieNode)
                self.word = False

        class Trie(object):
            def __init__(self):
                self.root = TrieNode()

            def insert(self, word):
                child = self.root
                for letter in word:
                    child = child.dict[letter]
                child.word = True

            def search(self, word):
                child = self.root
                for letter in word:
                    child = child.dict.get(letter)
                    if child is None:
                        return False
                return child.word


        class Solution:
            def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
                n = len(s)
                trie = Trie()
                ## 构建字典树
                for word in wordDict:
                    trie.insert(word)
                ## 前一个切分点的下标
                pre = [[] for i in range(n+1)]
                pre[0].append(-1)
                ## 前 i 个字符的切分
                for i in range(1, n+1):
                    for j in range(i):
                        if pre[j] != []:
                            ## 当前子串：s[j:i]
                            if trie.search(s[j:i]):
                                pre[i].append(j)
                res = []
                seg = ""
                ## 递归获取所有切分方式
                self.combineWords(s, pre, n, seg, res)
                return res
            
            def combineWords(self, s, pre, t, seg, res):
                if t == 0:
                    res.append(seg[:-1])
                    return
                for j in pre[t]:
                    self.combineWords(s, pre, j, s[j:t] + " " + seg, res)


[LeetCode] Gas Station 加油站回路
--------------------------------------------------------------------------------------------

Hint：只要 gas 总和不小于 cost 总和，一定存在可以完成回路的出发点。

https://leetcode.com/problems/gas-station/

https://leetcode.com/problems/gas-station/discuss/191463/topic

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int canCompleteCircuit(vector<int>& gas, vector<int>& cost)
          {
              if(gas.size() == 0) return -1;
              int totalDiff = 0;
              int currDiff = 0;
              int start = 0;
              for(int i = 0; i < gas.size(); ++i)
              {
                  totalDiff += gas[i] - cost[i];
                  currDiff += gas[i] - cost[i];
                  if(currDiff < 0)
                  {
                      start = i + 1; // 第 0 ~ i 加油站都不可能是可以完成回路的起始点
                      currDiff = 0;
                  }
              }
              return totalDiff >= 0 ? start: -1;
          }
      };

延伸：从起点到终点的最少加油次数。Hint：贪心算法，把路过的每个加油站的油量存入优先队列，当需要加油时，
弹出队列中的最大油量。

https://leetcode.com/problems/minimum-number-of-refueling-stops/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution 
      {
      public:
          int minRefuelStops(int target, int startFuel, vector<vector<int>>& stations) 
          {
              priority_queue<int, vector<int>, less<int>> que;
              int cnt = 0;
              int maxDist = startFuel;
              int i = 0;
              while(maxDist < target)
              {
                  while(i < stations.size() && maxDist >= stations[i][0])
                  {
                      que.push(stations[i][1]);
                      ++i;
                  }
                  if(que.empty()) return -1;
                  maxDist += que.top();
                  que.pop();
                  cnt += 1;
              }
              return cnt;
          }
      };

最短过桥时间
--------------------------------------------------------------------------------------------

:math:`n` 个人过桥，每次最多通过两个人（过桥时间按较长者计算），只有一个手电筒，每次过桥之后需要一个人把手电筒送回来，求最短过桥时间。Hint：耗时第 :math:`k` 小的人过桥有两种方案，第一，由耗时最短的人送回手电筒，并陪同过河；
第二，耗时最短的人送回手电筒之后，耗时第 :math:`k` 小的人与耗时第 :math:`k-1` 小的人一起过桥，他们过桥之后，手电筒再由耗时第二短的人送回，最后耗时最短的人和耗时第二短的人一起过桥。

https://blog.csdn.net/u014113686/article/details/82464635

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      int minTimeCrossBridge(int* time, int n)
      {
          assert(n > 0);
          sort(time, time + n);
          int* dp = new int[n];
          dp[0] = time[0];
          dp[1] = time[1];
          for (size_t i = 2; i < n; ++i)
          {
              dp[i] = min(dp[i - 1] + time[0] + time[i], dp[i - 2] + time[i] + time[0] + 2 * time[1]);
          }
          int res = dp[n - 1];
          delete[] dp;
          return res;
      }


[LeetCode] Minimum Window Substring 字符串 S 中包含字符串 T 中所有字符的最短子串
----------------------------------------------------------------------------------------------------------

Hint：用两个指针表示滑动窗口的起始和结尾；当窗口满足要求，则计算当前窗口的长度，然后两个指针都往后移动一步；终止条件是尾指针移动到了字符串 S 的结尾（'\\0'）。

延伸：不考虑字符串 T 中重复的字符，求字符串 S 中包含字符串 T 中出现的字符的最短子串。

https://leetcode.com/problems/minimum-window-substring/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 考虑重复

      typedef unsigned int uint;
      class Solution
      {
      public:
          string minWindow(string s, string t)
          {
              uint lenS = s.size();
              uint lenT = t.size();
              if(lenS < lenT || lenT == 0) return "";

              uint hashT[256] = {0};
              for(size_t k = 0; k < lenT; ++k)
              {
                  hashT[t[k]] += 1; // 统计 T 中的字符，考虑重复
              }
              uint hashWindow[256] = {0}; // 统计 S 的滑动窗口中出现在 T 中的字符

              uint start = 0;
              uint minLen = lenS + 1;
              uint pBegin = 0;
              uint pEnd = -1; // 双指针初始化
              uint matchCnt = 0; // 统计当前滑动窗口中匹配的字符对
              while(true)
              {
                  if(matchCnt == lenT) //  T 中所有字符都出现
                  {
                      while(hashT[s[pBegin]] == 0 || hashWindow[s[pBegin]] > hashT[s[pBegin]]) // 收紧窗口的左端，第二个条件表示窗口中包含了多余的重复字符
                      {
                          --hashWindow[s[pBegin]];
                          ++pBegin;
                      }
                      if(pEnd - pBegin + 1 < minLen)
                      {
                          minLen = pEnd - pBegin + 1;
                          start = pBegin;
                      }
                      --matchCnt;
                      --hashWindow[s[pBegin]];
                      ++pBegin; // 起始指针往后移动，相应统计量 -1
                  }
                  ++pEnd;
                  if(pEnd == lenS) break;
                  ++hashWindow[s[pEnd]];
                  if(hashT[s[pEnd]] > 0 && hashWindow[s[pEnd]] <= hashT[s[pEnd]]) ++matchCnt; // 新增匹配
              }
              if(minLen == lenS + 1) return "";
              else return s.substr(start, minLen);
          }
      };

    .. code-block:: cpp
      :linenos:

      // 不考虑重复

      typedef unsigned int uint;
      class Solution
      {
      public:
          string minWindow(string s, string t)
          {
              uint lenS = s.size();
              uint lenT = t.size();
              if (lenS < lenT || lenT == 0) return "";

              uint hashT[256] = { 0 };
              uint uniqueChar = 0;
              for (size_t k = 0; k < lenT; ++k)
              {
                  if (hashT[t[k]] == 0) uniqueChar += 1; // 统计 T 中的字符，不考虑重复
                  hashT[t[k]] = 1; // 不管出现多少次，都是 1
              }
              uint hashWindow[256] = { 0 };

              uint start = 0;
              uint minLen = lenS + 1;
              uint pBegin = 0;
              uint pEnd = -1;
              uint matchCnt = 0;
              while (true)
              {
                  if (matchCnt == uniqueChar) // 匹配了 T 中所有字符
                  {
                      while (hashT[s[pBegin]] == 0 || hashWindow[s[pBegin]] > 1) // 收紧窗口的左端，第二个条件表示窗口中包含了多余的重复字符
                      {
                          --hashWindow[s[pBegin]];
                          ++pBegin;
                      }
                      if (pEnd - pBegin + 1 < minLen)
                      {
                          minLen = pEnd - pBegin + 1;
                          start = pBegin;
                      }
                      --matchCnt;
                      --hashWindow[s[pBegin]];
                      ++pBegin; // 起始指针往后移动，相应统计量 -1
                  }
                  ++pEnd;
                  if (pEnd == lenS) break;
                  ++hashWindow[s[pEnd]];
                  if(hashT[s[pEnd]] > 0 && hashWindow[s[pEnd]] == 1) ++matchCnt; // 新增匹配
              }
              if (minLen == lenS + 1) return "";
              else return s.substr(start, minLen);
          }
      };

相关题：从字符串首/末取字符，至少包含 :math:`k` 个 a、b、c。Hint：双指针，时间复杂度 :math:`\mathcal{O}(N)` 。

https://leetcode.com/problems/take-k-of-each-character-from-left-and-right

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        from collections import Counter
        class Solution:
            def takeCharacters(self, s: str, k: int) -> int:
                c = Counter(s)
                if c['a'] < k or c['b'] < k or c['c'] < k:
                    return -1
                n = len(s)
                l = 0
                res = n
                ## 区间 [l, r] 不取
                ## 遍历 r
                for r in range(n):
                    c[s[r]] -= 1
                    while c['a'] < k or c['b'] < k or c['c'] < k:
                        c[s[l]] += 1
                        l += 1
                    res = min(res, n - (r - l + 1))
                return res

[LeetCode] Continuous Subarrays 连续数组（元素之差不超过 2）的数量
--------------------------------------------------------------------------------------------

Hint：双指针。字典插入、删除、查找最大值/最小值的时间复杂度是 :math:`\mathcal{O}(\log k)` 。

https://leetcode.com/problems/continuous-subarrays

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        from collections import defaultdict
        class Solution:
            def continuousSubarrays(self, nums: List[int]) -> int:
                freq = defaultdict(int)
                left, right = 0, 0
                cnt = 0
                n = len(nums)
                while right < n:
                    freq[nums[right]] += 1
                    ## min/max 复杂度 O(log k), k <= 3
                    while left <= right and max(freq) - min(freq) > 2:
                        freq[nums[left]] -= 1
                        ## 出队，避免影响 min/max 的统计
                        if freq[nums[left]] == 0:
                            freq.pop(nums[left])
                        left += 1
                    ## 以 right 结尾的子数组个数
                    cnt += right - left + 1
                    right += 1
                return cnt

[LeetCode] Nth Digit 第 :math:`N` 个数字
--------------------------------------------------------------------------------------------

Hint：:math:`k` 位数的个数是 :math:`9 \times 10^{k-1}` ，例如，两位数有 :math:`90` 个；先确定第 :math:`N` 个数字是几位数，再定位到具体的数，取出相应数字。

https://leetcode.com/problems/nth-digit/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int findNthDigit(int n)
          {
              int sum = 0;
              int k = 1;
              while(sum + k * 9 * pow(10, k-1) < n)
              {
                  sum += k * 9 * pow(10, k-1);
                  k++;
              }
              int a = (n - sum) / k;
              int b = (n - sum) % k;
              int num = pow(10, k-1) + a - 1; // 定位到具体的数
              if(b == 0) return num % 10; // 当前数的最后一位数字（个位）
              else return ((num + 1) / static_cast<int>(pow(10, k-b))) % 10; // 下一个数的第 b 位数字
          }
      };


[LeetCode] Pow(x, n) 求幂
--------------------------------------------------------------------------------------------

Hint：:math:`x^{2k} = x^k \times x^k,\ x^{2k+1} = x \times x^k \times x^k` 。

https://leetcode.com/problems/powx-n/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 递归

      double myPow(double x, int n)
      {
          if(fabs(x) < 1e-7)
          {
              if(n < 0) throw logic_error("ZeroDivisionError"); // 底数为 0， 指数为负
              return 1.0;
          }
          if(n == 0) return 1;
          if(n == 1) return x;
          if(n < 0)
          {
              if(n == INT_MIN) return 1/x * myPow(1/x, - (n + 1)); // - INT_MIN 溢出
              else return myPow(1/x, - n);
          }
          double tmp = myPow(x, n/2);
          if(n % 2) return x * tmp * tmp;
          else return tmp * tmp;
      }

    .. code-block:: cpp
      :linenos:

      // 迭代

      double myPow(double x, int n)
      {
          if(fabs(x) < 1e-7)
          {
              if(n < 0) throw logic_error("ZeroDivisionError"); // 底数为 0， 指数为负
              return 1.0;
          }

          if(n == 0) return 1.0;
          if(n == 1) return x;

          double ans = 1.0;

          if(n < 0)
          {
              x = 1/x;
              if(n == INT_MIN) // - INT_MIN 溢出
              {
                  ans *= x;
                  n = INT_MAX;
              }
              else n = - n;
          }

          while(n > 0)
          {
              int k = 1;
              double tmp = x;
              while(k <= n/2)
              {
                  tmp *= tmp;
                  k <<= 1;
              }
              n -= k;
              ans *= tmp;
          }

          return ans;
      }

[LeetCode] Longest Valid Parentheses 最长有效匹配括号长度
--------------------------------------------------------------------------------------------

https://leetcode.com/problems/longest-valid-parentheses/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一：动态规划
      // 设 dp[i] 表示以 s[i] 结尾的最长匹配长度
      // 当 s[i] = '(' ，dp[i] = 0
      // 当 s[i] = ')' 且 s[i-1] = '(' ，dp[i] = dp[i-2] + 2
      // 当 s[i] = ')' 且 s[i-1] = ')' ，需要找到与 s[i] 匹配的左括号的位置，而以 s[i-1] 结尾的最长匹配组的长度为 dp[i-1]，
      // 因此与 s[i] 匹配的位置为 i - 1 - dp[i-1]

      class Solution
      {
      public:
          int longestValidParentheses(string s)
          {
              if(s.size() <= 1) return 0;
              vector<int> dp(s.size(), 0);
              int res = 0;
              for(int i = 1; i < s.size(); ++i)
              {
                  if(s[i] == ')')
                  {
                      if(s[i-1] == '(') dp[i] = i-2 >= 0 ? dp[i-2] + 2 : 2;
                      else
                      {
                          int left = i - 1 - dp[i-1];
                          if(left >= 0 && s[left] == '(')
                          {
                              dp[i] = left > 0 ? dp[left-1] + dp[i-1] + 2 : dp[i-1] + 2;
                          }
                      }
                  }
                  res = max(res, dp[i]);
              }
              vector<int>().swap(dp);
              return res;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 方法二：栈
      // 将达成匹配的括号的flag置为true
      // 求flag为true的最长连续子数组
      class Solution 
      {
      public:
          int longestValidParentheses(string s) 
          {
              const int LEN = s.size();
              if(LEN <= 1) return 0;
              stack<int> id_stk;
              vector<bool> match_flag(LEN, false);
              for(int k = 0; k < LEN; ++k)
              {
                  if(s.at(k) == '(') id_stk.push(k);
                  else if(!id_stk.empty())
                  {
                      match_flag[id_stk.top()] = true; // left parentheses
                      match_flag[k] = true; // right parentheses
                      id_stk.pop();
                  }
              }
              int res = 0;
              int begin = -1;
              // longest continuous 'true'
              for(int end = 0; end < LEN; ++end)
              {
                  if(match_flag[end] && begin == -1) begin = end;
                  else if(begin > -1 && (end+1 == LEN or !match_flag[end+1]))
                  {
                      res = max(res, end - begin + 1);
                      begin = -1;
                  }
              }
              return res;
          }
      };

丢弃的数
--------------------------------------------------------------------------------------------

从 :math:`1,2,...,n` 中取丢弃 :math:`k` 个数，剩余的数形成一个数组 :math:`v` ，求出丢弃的数。

- :math:`k=1` 
    
  :math:`a = \sum_{i=1}^n i - \sum_{j=1} v_j` 。

- :math:`k=2` 
    
  :math:`a + b = \sum_{i=1}^n i - \sum_{j=1} v_j,\ a \times b = n! / \prod_{j=1} v_j` 。
    
  考虑到连乘可能溢出，可以使用平方和 :math:`a^2 + b^2 = \sum_{i=1}^n i^2 - \sum_{j=1} v_j^2` 。

[LeetCode] Trapping Rain Water 接雨水
--------------------------------------------------------------------------------------------

Hint：方法一，水从地面往上溢，统计每一层的积水，时间复杂度 :math:`\mathcal{O}(NH_{max})` ；方法二，双指针，当左高右低，推进右边的指针，当左低右高，推进左边的指针。

https://leetcode.com/problems/trapping-rain-water/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一

      class Solution
      {
      public:
          int trap(vector<int>& height)
          {
              if(height.size() <= 1) return 0;

              int maxh = *max_element(height.begin(), height.end());
              int ans = 0;
              for(int h = 1; h <= maxh; ++h)
              {
                  vector<int> idx;
                  for(int i = 0; i < height.size(); ++i)
                  {
                      if(height[i] >= h) idx.push_back(i); // 找到所有会积水的区间
                  }
                  if(idx.size() < 2) break;
                  for(int j = 0; j < idx.size() - 1; ++j)
                  {
                      ans += idx[j+1] - idx[j] - 1; // 第 h 层的积水量
                  }
              }
              return ans;
          }
      };


    .. code-block:: cpp
      :linenos:

      // 方法二

      class Solution
      {
      public:
          int trap(vector<int>& height)
          {
              if(height.size() <= 1) return 0;

              int ans = 0;

              int left = 0;
              int leftmax = height[0];
              int right = height.size() - 1;
              int rightmax = height[right];
              while(left < right)
              {
                  if(height[left] < height[right]) // 左低右高
                  {
                      if(height[left] <= leftmax)
                      {
                          ans += leftmax - height[left];
                          ++left;
                      }
                      else leftmax = height[left];
                  }
                  else // 左高右低
                  {
                      if(height[right] <= rightmax)
                      {
                          ans += rightmax - height[right];
                          --right;
                      }
                      else rightmax = height[right];
                  }
              }
              return ans;
          }
      };

[LeetCode] Sudoku Solver 数独
--------------------------------------------------------------------------------------------

https://leetcode.com/problems/sudoku-solver/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // code 用于编码数字出现的位置
      struct code
      {
          int a;
          int b;
          char digit;
          code(int _a, int _b, char _digit): a(_a), b(_b), digit(_digit){}
          bool operator<(const code& rhs) const // 两个 const
          {
              if(digit < rhs.digit) return true;
              if(digit > rhs.digit) return false;
              if(a < rhs.a) return true;
              if(a > rhs.a) return false;
              if(b < rhs.b) return true;
              return false;
          }
          /* 这里重载运算符 < 把 a，b，digit 都作为关键字，这对于后面 set 的 find 操作很关键。 */
          /* 假如只使用 digit 作为关键字，set 将把 (1,2,'1') 和 (3,5,'1') 视为相同的元素。 */
      };

      class Solution
      {
      public:
          void solveSudoku(vector<vector<char>>& board)
          {
              if(board.size() != 9 || board[0].size() != 9) return;
              set<code> used;
              for(int r = 0; r < 9; ++r)
              {
                  for(int c = 0; c < 9; ++c)
                  {
                      if(board[r][c] != '.')
                      {
                          used.emplace(code(r, -1, board[r][c])); // 第 r 行出现了 board[r][c]
                          used.emplace(code(-1, c, board[r][c])); // 第 c 列出现了 board[r][c]
                          used.emplace(code(r/3, c/3, board[r][c])); // 第 (r/3, c/3) 块出现了 board[r][c]
                      }
                  }
              }
              solveSudoku(board, used, 0);
          }
      private:
          bool solveSudoku(vector<vector<char>>& board, set<code>& used, int t)
          {
              while(t < 81 && board[t/9][t%9] != '.') ++t;
              if(t == 81) return true;
              int r = t / 9;
              int c = t % 9;
              for(int k = 1; k <= 9; ++k)
              {
                  char digit = '0' + k;
                  code rowcode(r, -1, digit);
                  code colcode(-1, c, digit);
                  code blockcode(r/3, c/3, digit);
                  if(used.find(rowcode) == used.end() && used.find(colcode) == used.end() && used.find(blockcode) == used.end())
                  {
                      board[r][c] = digit;
                      used.emplace(rowcode);
                      used.emplace(colcode);
                      used.emplace(blockcode);
                      if(solveSudoku(board, used, t + 1)) return true;
                      used.erase(rowcode);
                      used.erase(colcode);
                      used.erase(blockcode);
                      board[r][c] = '.'; // 擦除
                  }
              }
              return false;
          }
      };

[LeetCode] Median of Two Sorted Arrays 两个排序数组的中位数
--------------------------------------------------------------------------------------------

Hint：方法一，归并，时间复杂度 :math:`\mathcal{O}(m+n)` ；方法二，二分查找，时间复杂度 :math:`\mathcal{O}(\log (m+n))` 。

https://leetcode.com/problems/median-of-two-sorted-arrays/

https://windliang.cc/2018/07/18/leetCode-4-Median-of-Two-Sorted-Arrays/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一

      class Solution 
      {
      public:
          double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) 
          {
              if(nums1.empty() && nums2.empty()) return 0.0;
              int m = nums1.size();
              int n = nums2.size();
              int i = 0;
              int j = 0;
              int k = 0;
              double median;
              double premedian;
              while(true)
              {
                  if(j == n || (i < m && nums1[i] <= nums2[j]))
                  {
                      median = nums1[i];
                      ++i;
                  }
                  else if(i == m || (j < n && nums1[i] > nums2[j]))
                  {
                      median = nums2[j];
                      ++j;
                  }
                  if((m+n)%2 == 1 && k == (m+n)/2) return median;
                  if((m+n)%2 == 0 && k == (m+n)/2-1) premedian = median;
                  if((m+n)%2 == 0 && k == (m+n)/2) return (premedian + median) / 2.0;
                  ++k;
              }
          }
      };

    .. code-block:: python
        :linenos:

        # 方法二

        class Solution:
            def findMedianSortedArrays(self, nums1: List[int], nums2: List[int]) -> float:
                n1, n2 = len(nums1), len(nums2)
                n = n1 + n2
                if n & 1:
                    return self.findKth(nums1, 0, n1, nums2, 0, n2, (n+1)//2)
                else: 
                    return (self.findKth(nums1, 0, n1, nums2, 0, n2, n//2) + 
                        self.findKth(nums1, 0, n1, nums2, 0, n2, n//2+1)) / 2.0

            def findKth(self, l1, i1, n1, l2, i2, n2, k):
                while True:
                    if i1 == n1: return l2[i2+k-1] # 区间为空
                    if i2 == n2: return l1[i1+k-1] # 区间为空
                    if k == 1: return min(l1[i1], l2[i2])
                    half = k // 2
                    j1, j2 = min(i1+half-1, n1-1), min(i2+half-1, n2-1)
                    if l1[j1] > l2[j2]:
                        k -= j2 - i2 + 1
                        i2 = j2 + 1
                    else:
                        k -= j1 - i1 + 1
                        i1 = j1 + 1

滑动窗口
--------------------------------------------------------------------------------------------

- [LeetCode] Sliding Window Maximum 滑动窗口最大值。Hint：使用双端队列；新加入元素如果比队尾元素小，则直接入队，否则删除队尾元素直到队空或队尾元素比新加入元素大；
  如果队首元素在滑动窗口之外，则删除之；队首元素就是当前窗口的最大值。

  https://leetcode.com/problems/sliding-window-maximum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          vector<int> maxSlidingWindow(vector<int>& nums, int k)
          {
              vector<int> win_max;
              if(nums.size() == 0 || k <= 0) return win_max;
              deque<int> que; // 双端队列，存的是元素下标
              for(int i = 0; i < k && i < nums.size(); ++i)
              {
                  while(!que.empty() && nums[que.back()] <= nums[i]) que.pop_back();
                  que.push_back(i);
              }
              win_max.push_back(nums[que.front()]); // 队首的是滑动窗口最大值
              for(int i = k; i < nums.size(); ++i)
              {
                  while(!que.empty() && nums[que.back()] <= nums[i]) que.pop_back();
                  if(!que.empty() && que.front() <= i - k) que.pop_front(); // 不属于当前滑动窗口
                  que.push_back(i);
                  win_max.push_back(nums[que.front()]);
              }
              return win_max;
          }
      };

- [LeetCode] Sliding Window Median 滑动窗口中位数。Hint：使用 multiset（包含重复元素、默认排序），加入/删除元素时调整 mid 的位置。

  https://leetcode.com/problems/sliding-window-median/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // https://leetcode.com/problems/sliding-window-median/discuss/96340/O(n-log-k)-C%2B%2B-using-multiset-and-updating-middle-iterator

      class Solution
      {
      public:
          vector<double> medianSlidingWindow(vector<int>& nums, int k)
          {
              multiset<int> window(nums.begin(), nums.begin()+k);
              auto mid = next(window.begin(), k/2); // #include<iterator>，next 返回一个迭代器，指向 window.begin() + k/2
              vector<double> medians;
              for(int i = k; i < nums.size(); ++i)
              {
                  medians.push_back((double(*mid) + *prev(mid, 1 - k%2)) / 2.0); // #include<iterator>，prev 返回一个迭代器，指向 mid - (1 - k%2)

                  // 比较插入/删除值与 *mid 的大小关系，共 4 种情况，相应调整 mid

                  window.insert(nums[i]);
                  if(nums[i] < *mid) --mid;

                  if(nums[i-k] <= *mid) ++mid;
                  window.erase(window.lower_bound(nums[i-k])); // 不能直接 erase(nums[i-k])，会删除所有重复元素
              }
              medians.push_back((double(*mid) + *prev(mid, 1 - k%2)) / 2.0); // 最后一个窗口的中位数

              return medians;
          }
      };


- [LeetCode] Find Median from Data Stream 数据流中的中位数。Hint：使用一个最大堆和一个最小堆；保证数据平均分配到两个堆中，两个堆的数据个数之差不超过1；当两个堆的数据个数是偶数（各占一半），新数据插入最小堆，否则插入最大堆（这样最小堆的数据个数总是比最大堆多1或相等）；保证最大堆中的数都不大于最小堆中的数。

  https://leetcode.com/problems/find-median-from-data-stream/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class MedianFinder 
      {
      public:
          MedianFinder() {}
          
          void addNum(int num) 
          {
              if((max_heap.size() + min_heap.size()) & 1)
              {
                  if(!min_heap.empty() && num > min_heap.top())
                  {
                  // 新数插入最小堆，最小堆中最小的数（堆顶）插入最大堆
                      min_heap.push(num);
                      num = min_heap.top();
                      min_heap.pop();
                  }
                  max_heap.push(num);
              }
              else
              {
                  if(!max_heap.empty() && num < max_heap.top())
                  {
                  // 新数插入最大堆，最大堆中最大的数（堆顶）插入最小堆
                      max_heap.push(num);
                      num = max_heap.top();
                      max_heap.pop();
                  }
                  min_heap.push(num);
              }
          }
          
          double findMedian() 
          {
              if((max_heap.size() + min_heap.size()) & 1) return min_heap.top();
              else return (max_heap.top() + min_heap.top()) / 2.0;
          }
      private:
          priority_queue<int, vector<int>, less<int>> max_heap;
          priority_queue<int, vector<int>, greater<int>> min_heap;
      };


逆波兰式：转换与求值
--------------------------------------------------------------------------------------------

https://leetcode.com/problems/evaluate-reverse-polish-notation/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`


    .. code-block:: cpp
      :linenos:

      /* 
      中缀表达式转后缀表达式（逆波兰式）
      遍历中缀表达式：
      1）如果遇到操作数，则直接输出。
      2）如果遇到左括号，则直接压入栈中。
      3）如果遇到右括号，则将栈中元素弹出，直到遇到左括号为止；左括号只弹出栈而不输出。
      4）如果遇到操作符，则检查栈顶元素优先级，如果其优先级**不低于**当前操作符（左括号除外），则弹出栈顶元素并输出；
      重复此过程直到：栈顶元素优先级小于当前操作符或者栈顶元素为左括号或者栈为空，然后将当前操作符压入栈中。
      5）表达式处理完毕，将栈中元素依次弹出。
      注意：只有遇到右括号的情况下才会弹出左括号，其他情况都不会弹出。
      */


      class ReversePolishNotation
      {
      public:
          // 假设输入表达式一定是正确的，且只包含个位整数、+-*/、括号
          vector<char> convertRPN(const string& expr)
          {
              vector<char> rpn;
              if(expr.size() < 1) return rpn;
              stack<char> op;
              for(auto& e: expr)
              {
                  if('0' <= e && e <= '9') rpn.push_back(e);
                  else if(e == '(') op.push(e);
                  else if(e == ')')
                  {
                      while(!op.empty() && op.top()!='(')
                      {
                          rpn.push_back(op.top());
                          op.pop();
                      }
                      op.pop(); // pop '('
                  }
                  // + - * /
                  else
                  {
                      while(!op.empty() && op.top()!='(' && prior.at(op.top())>=prior.at(e))
                      {
                          rpn.push_back(op.top());
                          op.pop();
                      }
                      op.push(e);
                  }
              }
              while(!op.empty())
              {
                  rpn.push_back(op.top());
                  op.pop();
              }
              return rpn;
          }
      private:
          static const unordered_map<char, int> prior;
      };

      const unordered_map<char, int> ReversePolishNotation::prior = {{'+', 1}, {'-', 1}, {'*', 2}, {'/', 2}};

    .. code-block:: cpp
      :linenos:

      /*
      逆波兰式求值
      遍历逆波兰式，遇到操作数就入栈；遇到操作符则出栈两个操作数执行运算，运算结果重新入栈；
      遍历结束时，栈内存放的是最终运算结果。
      */

      class Solution 
      {
      public:
          int evalRPN(vector<string>& tokens)
          {
              int N = tokens.size();
              if(N == 0) return 0;
              stack<int> stk;
              int k = 0;
              int res = 0;
              while(k < N)
              {
                  if(tokens[k] != "*" && tokens[k] != "-" && tokens[k] != "+" && tokens[k] != "/")
                  {
                      stk.push(atoi(tokens[k].c_str()));
                  }
                  else
                  {
                      int right_operand = stk.top();
                      stk.pop();
                      int left_operand = stk.top();
                      stk.pop();
                      switch(tokens[k][0])
                      {
                          case '+': res = left_operand + right_operand; break;
                          case '-': res = left_operand - right_operand; break;
                          case '*': res = left_operand * right_operand; break;
                          case '/': res = left_operand / right_operand; break; 
                      }
                      stk.push(res);
                  }
                  k++;
              }
              if(!stk.empty())
              {
                  res = stk.top();
                  stk.pop();
              }
              return res;
          }
      };

https://leetcode.cn/problems/calculator-lcci

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def calculate(self, s: str) -> int:
                def scan_num(s, i):
                    num = 0
                    while i < len(s) and ord('0') <= ord(s[i]) <= ord('9'):
                        num = num * 10 + int(s[i])
                        i += 1
                    return i, num
                def scan_op(s, i):
                    return i + 1, s[i]
                def eval_op(num_stk, op):
                    rhs = num_stk.pop()
                    lhs = num_stk.pop()
                    if op == '+':
                        num_stk.append(lhs + rhs)
                    elif op == '-':
                        num_stk.append(lhs - rhs)
                    elif op == '*':
                        num_stk.append(lhs * rhs)
                    else:
                        num_stk.append(lhs // rhs)
                s = s.replace(' ', '')
                n = len(s)
                op_stk, num_stk = [], []
                prior = {'+': 0, '-': 0, '*': 1, '/': 1}
                i, num = scan_num(s, 0)
                num_stk.append(num)
                while i < n:
                    i, op = scan_op(s, i)
                    while op_stk and prior[op] <= prior[op_stk[-1]]:
                        eval_op(num_stk, op_stk[-1])
                        op_stk.pop()
                    op_stk.append(op)
                    i, num = scan_num(s, i)
                    num_stk.append(num)
                while op_stk:
                    eval_op(num_stk, op_stk[-1])
                    op_stk.pop()
                return num_stk[0]


字典树/前缀树（ `Trie <https://oi-wiki.org/string/trie/>`_ ）
--------------------------------------------------------------------------------------------

字典树/前缀树的查找时间复杂度是 :math:`\mathcal{O}(l)` ，创建一棵树的时间复杂度是 :math:`\mathcal{O}(nl)` ，
其中 :math:`l` 是单词长度， :math:`n` 是字典大小。

https://leetcode.com/problems/implement-trie-prefix-tree


  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class TrieNode
      {
      public:
          TrieNode* child[26];
          bool has_word;
          TrieNode()
          {
              fill(child, child+26, nullptr);
              has_word = false;
          }
      };

      class Trie 
      {
      public:
          /** Initialize your data structure here. */
          Trie() 
          {
              root = new TrieNode();
          }
          
          /** Inserts a word into the trie. */
          void insert(string word) 
          {
              TrieNode* p = root;
              for(auto& c: word)
              {
                  int branch = c - 'a';
                  if(p->child[branch] == nullptr) p->child[branch] = new TrieNode();
                  p = p->child[branch];
              }
              p->has_word = true;
          }
          
          /** Returns if the word is in the trie. */
          bool search(string word) 
          {
              TrieNode* p = root;
              for(auto& c: word)
              {
                  int branch = c - 'a';
                  if(p->child[branch] == nullptr) return false;
                  p = p->child[branch];
              }
              return p->has_word;
          }
          
          /** Returns if there is any word in the trie that starts with the given prefix. */
          bool startsWith(string prefix) 
          {
              TrieNode* p = root;
              for(auto& c: prefix)
              {
                  int branch = c - 'a';
                  if(p->child[branch] == nullptr) return false;
                  p = p->child[branch];
              }
              return true;
          }
      private:
          TrieNode* root;
      };

    .. code-block:: python
      :linenos:

      from collections import defaultdict

      class TrieNode(object):
          def __init__(self):
              self.dict = defaultdict(TrieNode)
              self.word = False
              
      class Trie(object):

          def __init__(self):
              """
              Initialize your data structure here.
              """
              self.root = TrieNode()

          def insert(self, word):
              """
              Inserts a word into the trie.
              :type word: str
              :rtype: None
              """
              child = self.root
              for letter in word:
                  child = child.dict[letter]
              child.word = True

          def search(self, word):
              """
              Returns if the word is in the trie.
              :type word: str
              :rtype: bool
              """
              child = self.root
              for letter in word:
                  child = child.dict.get(letter)
                  if child is None:
                      return False
              return child.word

          def startsWith(self, prefix):
              """
              Returns if there is any word in the trie that starts with the given prefix.
              :type prefix: str
              :rtype: bool
              """
              child = self.root
              for letter in prefix:
                  child = child.dict.get(letter)
                  if child is None:
                      return False
              return True


LRU（Least Recently Used） 缓存机制
--------------------------------------------------------------------------------------------

Hint：通过双向链表辅以哈希表实现；双向链表按照被使用的顺序存储了这些键值对，靠近头部的键值对是最近使用的，而靠近尾部的键值对是最久未使用的；哈希表将缓存数据的 key 映射到其在双向链表中的位置；访问和插入数据的时间复杂度都是 :math:`\mathcal{O}(1)` 。

https://leetcode.com/problems/lru-cache/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class LRUCache 
      {
      public:
          LRUCache(int capacity): cache_capacity(capacity){}
              
          int get(int key) 
          {
              if(cache_loc.find(key) == cache_loc.end()) return -1;
              auto p = cache_loc[key];
              int value = p->second;
              cache.erase(p);
              cache.emplace_front(key, value); // 最新访问的数据需要移到链表头部
              cache_loc[key] = cache.begin();
              return value;
          }
          
          void put(int key, int value) 
          {
              if(cache_loc.find(key) != cache_loc.end())
              {
                  auto p = cache_loc[key];
                  cache.erase(p);
                  cache.emplace_front(key, value);
                  cache_loc[key] = cache.begin();
                  return;
                  
              }
              if(cache.size() == cache_capacity)
              {
                  auto tail = cache.back();
                  cache.pop_back();
                  cache_loc.erase(tail.first);
              }
              cache.emplace_front(key, value);
              cache_loc[key] = cache.begin();
          }
      private:
          int cache_capacity;
          list<pair<int,int>> cache;
          unordered_map<int, list<pair<int,int>>::iterator> cache_loc;
      };


[LeetCode] House Robber II 环形房屋偷盗
--------------------------------------------------------------------------------------------

Hint：在区间 :math:`[0, n-2]` 和区间 :math:`[1, n-1]` 分别做动态规划。

https://leetcode-cn.com/problems/house-robber-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution 
      {
      public:
          int rob(vector<int>& nums) 
          {
              int n = nums.size();
              if(n == 0) return 0;
              if(n == 1) return nums[0];
              int res = 0;
              _rob(nums, 0, n-2, res);
              _rob(nums, 1, n-1, res);
              return res;
          }
      private:
          void _rob(vector<int>& nums, int from, int to, int& res)
          {
              vector<int> dp(nums);
              res = max(res, nums[from]);
              for(int i = from+1; i <= to; ++i)
              {
                  for(int j = from; j < i-1; ++j) dp[i] = max(dp[i], dp[j] + nums[i]);
                  res = max(res, dp[i]);
              }
          }
      };

[LeetCode] Serialize And Deserialize Binary Tree 序列化与反序列化二叉树
--------------------------------------------------------------------------------------------

https://leetcode-cn.com/problems/h54YBf/

https://leetcode.com/problems/serialize-and-deserialize-binary-tree/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Codec {
      public:
          // Encodes a tree to a single string.
          string serialize(TreeNode* root) {
              // # 作为空节点, $ 用于分割不同节点的 val
              if(!root) return "#";
              return to_string(root->val) + 
                  "$" + 
                  serialize(root->left) + 
                  serialize(root->right);
          }

          // Decodes your encoded data to tree.
          TreeNode* deserialize(string data) {
              if(data.empty()) return nullptr;
              int i = 0;
              TreeNode* root = deserialize(data, i);
              return root;
          }
      private:
          TreeNode* deserialize(string& data, int& i)
          {
              if(data[i] == '#')
              {
                  // 注意这里 i 一定要自增
                  ++i;
                  return nullptr;
              }
              int val = scanDigit(data, i);
              TreeNode* node = new TreeNode(val);
              node->left = deserialize(data, i);
              node->right = deserialize(data, i);
              return node;
          }
          int scanDigit(string& data, int& i)
          {
              if(i == data.size()) return -9999;
              bool pos = true;
              if(data[i] == '-')
              {
                  pos = false;
                  i++;
              }
              int res = 0;
              while(i < data.size() && '0' <= data[i] && data[i] <= '9')
              {
                  res = 10 * res + data[i] - '0';
                  i++;
              }
              ++i; // 略过 $
              return pos? res: -1*res;
          }
      };

[LeetCode] 生存人数：统计生存人数最多的年份
--------------------------------------------------------------------------------------------

Hint：用差分数组记录出生年份和死亡年份的人数变化，差分数组的前缀和表示该年份的生存人数。

https://leetcode.cn/problems/living-people-lcci/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution 
      {
      public:
          int maxAliveYear(vector<int>& birth, vector<int>& death) 
          {
              const int SY = 1900;
              const int EY = 2000;
              int count[EY - SY + 2] = {0};
              int N = birth.size();
              for(int i = 0; i < N; ++i)
              {
                  count[birth[i] - SY] += 1;
                  count[death[i] + 1 - SY] -= 1; // 区间 [birth[i], death[i]] 内生存人数都+1
              }
              int most = 0, year = -1;
              int sum = 0;
              for(int k = 0; k <= EY - SY; ++k)
              {
                  sum += count[k];
                  if(sum > most)
                  {
                      most = sum;
                      year = k + SY;
                  }
              }
              return year;
          }
      };


[LeetCode] 验证栈的压入、弹出序列
----------------------------------------------------

Hint：如果下一个弹出的数字正好是栈顶数字，那么直接弹出；如果下一个弹出的数字不在栈顶，就把压栈序列中还没入栈的数字
压入辅助栈，直到把下一个需要弹出的数字压入栈为止。如果所有的数字都压入栈了，仍然没找到下一个弹出的数字，那么该序列
不可能是一个弹出序列。

https://leetcode.com/problems/validate-stack-sequences

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def validateStackSequences(self, pushed: List[int], popped: List[int]) -> bool:
                stk = []
                i, j = 0, 0
                n = len(pushed)
                while i < n and j < n:
                    if len(stk) > 0 and stk[-1] == popped[j]:
                        stk.pop()
                        j += 1
                    else:
                        stk.append(pushed[i])
                        i += 1
                if i == n:
                    while len(stk) > 0 and stk[-1] == popped[j]:
                        stk.pop()
                        j += 1
                    if j == n: return True
                return False


[LeetCode] 和为 s 的连续正数序列
----------------------------------------

Hint：双指针。

https://leetcode.cn/problems/he-wei-sde-lian-xu-zheng-shu-xu-lie-lcof/

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def findContinuousSequence(self, target: int) -> List[List[int]]:
                res = []
                begin, end = 1, 2
                s = begin + end
                while begin < end:
                    if s == target:
                        res.append(list(range(begin, end+1)))
                        s -= begin
                        begin += 1
                        end += 1
                        s += end
                    elif s < target:
                        end += 1
                        s += end
                    else:
                        s -= begin
                        begin += 1
                return res

延伸：统计和为 n 的序列的个数。

https://leetcode.com/problems/consecutive-numbers-sum

  .. math::

    x + (x+1) + \cdots + (x+k-1) & = \frac{k(2x+k-1)}{2},\ x > 0,\ k > 0 \\
                                & = kx + \frac{k(k-1)}{2} \\
                                & \geq  \frac{k(k+1)}{2}

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        import math
        class Solution:
            def consecutiveNumbersSum(self, n: int) -> int:
                ans = 0
                for k in range(1, int(math.sqrt(2*n))+1):
                    s = k*(k-1)//2
                    if (n - s) % k == 0:
                        ans += 1
                return ans

[LeetCode] Rotting Oranges 腐败的橙子
--------------------------------------------

Hint：多源 BFS，同时从各个源推进一步；双端队列。

https://leetcode.com/problems/rotting-oranges


  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def orangesRotting(self, grid: List[List[int]]) -> int:
                if not grid or not grid[0]: return 0
                m, n = len(grid), len(grid[0])
                maxd = 100
                dq = deque()
                fresh = 0
                for x in range(m):
                    for y in range(n):
                        if grid[x][y] == 2:
                            dq.append((x,y))
                        elif grid[x][y] == 1:
                            fresh += 1
                minutes = 0
                ## fresh = 0 就不需要再遍历了
                while len(dq) and fresh > 0:
                    ## sn 代表源的数量
                    sn = len(dq)
                    for i in range(sn):
                        x, y = dq.popleft()
                        for dx, dy in [[-1,0], [0,-1], [0,1], [1,0]]:
                            _x, _y = x + dx, y + dy
                            if 0 <= _x < m and 0 <= _y < n and grid[_x][_y] == 1:
                                grid[_x][_y] = 2
                                dq.append((_x, _y))
                                fresh -= 1
                    minutes += 1
                if fresh == 0: return minutes
                else: return -1

[LeetCode] Maximum Width of Binary Tree 二叉树最大宽度
----------------------------------------------------------------

Hint：层序遍历，计算每层最左边和最右边节点的序号之差作为该层的宽度。

https://leetcode.com/problems/maximum-width-of-binary-tree


  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        # Definition for a binary tree node.
        # class TreeNode:
        #     def __init__(self, val=0, left=None, right=None):
        #         self.val = val
        #         self.left = left
        #         self.right = right
        class Solution:
            def widthOfBinaryTree(self, root: Optional[TreeNode]) -> int:
                if root is None: return 0
                dq = deque([(root, 1)])
                r = []
                while len(dq):
                    n = len(dq)
                    ## 为了避免溢出，每层最左侧的节点编号都从 1 开始
                    ## r 保存每一层最右侧的节点的编号，其值就等于相应层的宽度
                    init = dq[0][1]
                    r.append(dq[-1][1] - init + 1)
                    for i in range(n):
                        p, idx = dq.popleft()
                        idx = idx - init + 1
                        if p.left:
                            ## 左节点编号
                            dq.append((p.left, idx*2))
                        if p.right:
                            ## 右节点编号
                            dq.append((p.right, idx*2+1))
                return max(r)

[LeetCode] Restore The Array 从字符串恢复整数数组
----------------------------------------------------------------

Hint：动态规划；整数不能以 0 开头；注意跳过数值范围明显越界的分割方法。

https://leetcode.com/problems/restore-the-array


  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def numberOfArrays(self, s: str, k: int) -> int:
                mod = 1000000007
                n = len(s)
                nk = len(str(k))
                dp = [0] * n
                dp[0] = 1
                for i in range(1, n):
                    if s[i] != '0':
                        ## s[i] 单独分割
                        dp[i] = dp[i-1]
                    else:
                        dp[i] = 0
                    ## s[j:i+1] 单独分割
                    ## 不需要去遍历明显越界的 s[j:i+1]
                    for j in range(max(0, i-nk), i):
                        if s[j] != '0':
                            dji = int(s[j:i+1])
                            if dji <= k:
                                dp[i] += dp[j-1] if j > 0 else 1
                                dp[i] %= mod
                return dp[-1]


重叠区间问题
----------------------------------------------------------------

一般使用贪心算法，先对序列排序；维护区间 start/end 的最小值。

- [LeetCode] Non-overlapping Intervals 不重叠区间。Hint：贪心算法，总是选择结束最早的区间。

  https://leetcode.com/problems/non-overlapping-intervals


  .. container:: toggle

      .. container:: header

          :math:`\color{darkgreen}{Code}`

      .. code-block:: python
          :linenos:

          class Solution:
              def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
                  intervals = sorted(intervals, key=lambda x: x[1])
                  pend = float("-inf")
                  cnt = 0
                  for start, end in intervals:
                      if start >= pend:
                          pend = end
                      else:
                          cnt += 1
                  return cnt

- [LeetCode] Minimum Number of Arrows to Burst Balloons 用最少数量的箭引爆气球。Hint：贪心算法。

  https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons

  .. container:: toggle

      .. container:: header

          :math:`\color{darkgreen}{Code}`

      .. code-block:: python
        :linenos:

        class Solution:
            def findMinArrowShots(self, points: List[List[int]]) -> int:
                points = sorted(points, key = lambda x: (x[1], x[0]))
                min_end = - 2**31 - 1
                ans = 0
                for start, end in points:
                    if start > min_end:
                        ## 在 x = min_end 处发射一支箭
                        min_end = end
                        ans += 1
                return ans

- [LeetCode] Maximum Beauty of an Array After Applying Operation 数组最大美感（最大重叠区间个数）。

  https://leetcode.com/problems/maximum-beauty-of-an-array-after-applying-operation

  .. container:: toggle

      .. container:: header

          :math:`\color{darkgreen}{Code}`

      .. code-block:: python
        :linenos:

        from collections import deque
        class Solution:
            def maximumBeauty(self, nums: List[int], k: int) -> int:
                intervals = []
                for num in nums:
                    intervals.append((num - k, num + k))
                intervals = sorted(intervals, key=lambda x: x[1])
                beauty = 1
                n = len(nums)
                dq = deque()
                for i in range(n):
                    s, e = intervals[i]
                    while len(dq) and intervals[dq[0]][1] < s:
                        dq.popleft()
                    dq.append(i)
                    beauty = max(beauty, len(dq))
                return beauty


[LeetCode] Stone Game 石头游戏
----------------------------------------------------------------

Hint：记忆化递归；动态规划。

https://leetcode.com/problems/stone-game-ii

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def stoneGameII(self, piles: List[int]) -> int:
                m = 1
                k = len(piles)
                ## 记录状态 (i, m) 的最大分
                mem = [[-1]*k for _ in range(k)]
                return self.maxScore(piles, 0, m, mem)
            
            def maxScore(self, piles, i, m, mem):
                if len(piles) - i <= 2*m:
                    return sum(piles[i:])
                if mem[i][m] >= 0:
                    return mem[i][m]
                ## 拿完 piles[i:i+x] 之后，要等对方从 i+x 开始拿，之后能拿到的最大分是 sum(piles[i+x:]) - self.maxScore(piles, i+x, max(m, x), mem)
                mem[i][m] = max([sum(piles[i:i+x]) + sum(piles[i+x:]) - self.maxScore(piles, i+x, max(m, x), mem) for x in range(1, 2*m+1)])
                return mem[i][m]


https://leetcode.com/problems/stone-game-iii

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        INT_MIN = -0x80000000
        class Solution:
            def stoneGameIII(self, stoneValue: List[int]) -> str:
                n = len(stoneValue)
                totalScore = sum(stoneValue)
                ## 后 n 项和，避免后续重复计算
                accuScore = [0] * (n+1)
                for i in range(n-1, -1, -1):
                    accuScore[i] = accuScore[i+1] + stoneValue[i]
                ## dp[i]：从第 i 堆石头开始拿能够得到的最大分
                dp = [0] * (n+1)
                for i in range(n-1, -1, -1):
                    takeOne = stoneValue[i] + accuScore[i+1] - dp[i+1]
                    takeTwo = INT_MIN
                    if i < n - 1:
                        takeTwo = sum(stoneValue[i:i+2]) + accuScore[i+2] - dp[i+2]
                    takeThree = INT_MIN
                    if i < n - 2:
                        takeThree = sum(stoneValue[i:i+3]) + accuScore[i+3] - dp[i+3]
                    dp[i] = max(takeOne, takeTwo, takeThree)
                
                aliceScore = dp[0] << 1
                if aliceScore == totalScore:
                    return "Tie"
                if aliceScore > totalScore:
                    return "Alice"
                return "Bob"

栈和队列的实现
----------------------------------------------------------------

https://leetcode.com/problems/implement-queue-using-stacks

Hint：总在第一个栈压入最新元素，在第二个栈弹出最旧元素。

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        class MyQueue 
        {
        public:
            MyQueue() {}
            
            void push(int x) 
            {
                s1.push(x);
            }
            
            int pop() 
            {
                int front = peek();
                s2.pop();
                return front;
            }
            
            int peek() 
            {
                if(s2.empty())
                {
                    while(!s1.empty())
                    {
                        s2.push(s1.top());
                        s1.pop();
                    }
                }
                return s2.top();
            }
            
            bool empty() 
            {
                return s1.empty() && s2.empty();
            }
        private:
            stack<int> s1;
            stack<int> s2;
        };

https://leetcode.com/problems/implement-stack-using-queues

Hint：总在第一个队列压入最新元素。

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
        :linenos:

        class MyStack 
        {
        public:
            MyStack() {}
            
            void push(int x) 
            {
                // 保证 q1 数据比 q2 新
                q1.push(x);
            }
            
            int pop() 
            {
                // 优先从 q1 弹出
                if(!q1.empty()) 
                {
                    while(q1.size() > 1)
                    {
                        q2.push(q1.front());
                        q1.pop();
                    }
                    int t = q1.front();
                    q1.pop();
                    return t;
                }
                else 
                {
                    while(q2.size() > 1)
                    {
                        q1.push(q2.front());
                        q2.pop();
                    }
                    int t = q2.front();
                    q2.pop();
                    return t;
                }
            }
            
            int top() 
            {
                if(!q1.empty()) 
                {
                    while(q1.size() > 1)
                    {
                        q2.push(q1.front());
                        q1.pop();
                    }
                    return q1.front();
                }
                else 
                {
                    while(q2.size() > 1)
                    {
                        q1.push(q2.front());
                        q2.pop();
                    }
                    int t = q2.front();
                    // 下面这一步很重要，保证 q2 的数据总是比 q1 旧
                    q1.push(t);
                    q2.pop();
                    return t;
                }
            }
            
            bool empty() 
            {
                return q1.empty() && q2.empty();
            }
        private:
            queue<int> q1;
            queue<int> q2;
        };


`单调栈 <https://algo.itcharge.cn/03.Stack/02.Monotone-Stack/01.Monotone-Stack/>`_
----------------------------------------------------------------------------------------------------

单调栈（Monotonic Stack）在栈的「先进后出」规则基础上，要求从栈顶到栈底的元素单调递增/递减。一般情况下，数组的每个元素都入栈一次，且至多出栈一次，因此时间复杂度是 :math:`\mathcal{O}(n)` 。

- [LeetCode] Daily Temperatures 每日温度。

  https://leetcode.com/problems/daily-temperatures

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution(object):
            def dailyTemperatures(self, temperatures):
                """
                :type temperatures: List[int]
                :rtype: List[int]
                """
                n = len(temperatures)
                ans = [0] * n
                stk = []
                ## 逆序遍历，栈顶元素最小
                for i in range(n-1, -1, -1):
                    while stk and temperatures[i] >= temperatures[stk[-1]]:
                        stk.pop()
                    if stk:
                        ans[i] = stk[-1] - i
                    ## 入栈
                    stk.append(i)
                return ans


- [LeetCode] Next Greater Element 下一个更大的元素。延伸：数组为循环数组，Hint：把原数组拷贝一遍追加在尾部，就可以模拟循环数组。

  https://leetcode.com/problems/next-greater-element-i

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def nextGreaterElement(self, nums1: List[int], nums2: List[int]) -> List[int]:
                ## 用字典存储已经找到的结果
                mp = {}
                stk = []
                ## 逆序遍历，栈顶元素最小
                for num in nums2[::-1]:
                    while stk and num >= stk[-1]:
                        stk.pop()
                    if stk:
                        mp[num] = stk[-1]
                    else:
                        mp[num] = -1
                    ## 入栈
                    stk.append(num)
                ans = []
                for num in nums1:
                    ans.append(mp[num])
                return ans

  https://leetcode.com/problems/next-greater-element-ii

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution(object):
            def nextGreaterElements(self, nums):
                """
                :type nums: List[int]
                :rtype: List[int]
                """
                n = len(nums)
                ## 把 nums 拷贝一遍就可以模拟循环数组 
                nums.extend(nums[:])
                stk = []
                ans = []
                for i in range(2*n-1, -1, -1):
                    while stk and nums[i] >= stk[-1]:
                        stk.pop()
                    if i < n:
                        if stk:
                            ans.append(stk[-1])
                        else:
                            ans.append(-1)
                    stk.append(nums[i])
                return ans[::-1]

- [LeetCode] Largest Rectangle in Histogram 直方图中的最大矩形面积。

  https://leetcode.com/problems/largest-rectangle-in-histogram

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution(object):
            def largestRectangleArea(self, height):
                """
                :type height: List[int]
                :rtype: int
                """
                if not height:
                    return 0
                ## 尾部追加 -1，方便计算以最后一个 bar 结尾的矩形面积
                height.append(-1)
                ans = 0
                stk = []
                ## 栈顶元素最大
                for i in range(len(height)):
                    while stk and height[i] < height[stk[-1]]:
                        last = stk[-1]
                        stk.pop()
                        h = height[last]
                        pre = stk[-1] if stk else -1
                        ## 计算 [pre + 1, i - 1] 之间的 bar 构成的矩形面积
                        ## pre = -1 代表高度最低的矩形，面积为 h * i
                        ans = max(ans, h * (i - 1 - pre))
                    ## 入栈
                    stk.append(i)
                return ans

- [LeetCode] Maximal Rectangle 矩阵中的最大矩形。Hint：以 :math:`0 \sim i-1` 行为底，以第 :math:`i` 行为顶，将问题转化为「直方图中的最大矩形面积」进行求解，其中直方图的高度为连续 1 的数量。

  https://leetcode.com/problems/maximal-rectangle

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def maximalRectangle(self, matrix: List[List[str]]) -> int:
                rows, cols = len(matrix), len(matrix[0])
                height = [0] * cols
                ans = 0
                for r in range(rows):
                    for c in range(cols):
                        if matrix[r][c] == '1':
                            height[c] += 1
                        else:
                            height[c] = 0 ## 注意，这里不是累加
                    ans = max(ans, self.largestRectangleArea(height))
                return ans

            def largestRectangleArea(self, height):
                """
                :type height: List[int]
                :rtype: int
                """
                if not height:
                    return 0
                ## 尾部追加 -1，方便计算以最后一个 bar 结尾的矩形面积
                height.append(-1)
                ans = 0
                stk = []
                ## 栈顶元素最大
                for i in range(len(height)):
                    while stk and height[i] < height[stk[-1]]:
                        last = stk[-1]
                        stk.pop()
                        h = height[last]
                        pre = stk[-1] if stk else -1
                        ## 计算 [pre, i) 之间的 bar 构成的矩形面积
                        ## pre = -1 代表高度最低的矩形，面积为 h * i
                        ans = max(ans, h * (i - 1 - pre))
                    ## 入栈
                    stk.append(i)
                return ans

- [LeetCode] Beautiful Towers I 美丽塔。Hint：两个单调栈（正向 + 反向），动态规划。

  https://leetcode.com/problems/beautiful-towers-i

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        class Solution:
            def maximumSumOfHeights(self, maxHeights: List[int]) -> int:
                n = len(maxHeights)
                ## prefix[i] 表示区间 [0, i] 能构成的非递减数组的元素和最大值，且位置 i 是山顶，高度为 maxHeights[i]
                ## suffix[i] 表示区间 [i, n) 能构成的非递增数组的元素和最大值，且位置 i 是山顶，高度为 maxHeights[i]
                ## 以位置 i 为山顶的 mountain 数组的元素和为：prefix[i] + suffix[i] - maxHeights[i]
                prefix = [0] * n
                suffix = [0] * n
                ## stk 保存下标
                stk = []
                for i in range(n):
                    while stk and maxHeights[stk[-1]] > maxHeights[i]:
                        stk.pop()
                    if not stk:
                        ## 区间 [0, i] 的高度统一设为 maxHeights[i]
                        prefix[i] = (i + 1) * maxHeights[i]
                    else:
                        ## 动态规划
                        ## 区间 (stk[-1], i] 的高度统一设为 maxHeights[i]
                        prefix[i] = prefix[stk[-1]] + (i - stk[-1]) * maxHeights[i]
                    stk.append(i)
                stk = []
                for i in range(n-1, -1, -1):
                    while stk and maxHeights[stk[-1]] > maxHeights[i]:
                        stk.pop()
                    if not stk:
                        suffix[i] = (n - i) * maxHeights[i]
                    else:
                        suffix[i] = suffix[stk[-1]] + (stk[-1] - i) * maxHeights[i]
                    stk.append(i)
                ans = 0
                for i in range(n):
                    ans = max(ans, prefix[i] + suffix[i] - maxHeights[i])
                return ans


单词接龙
-----------------------------

- [LeetCode] Word Ladder 单词接龙（最短路径的长度）。Hint：BFS。

  https://leetcode.com/problems/word-ladder

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        ## l 单词长度，n 单词数量
        ## 预先计算好两两单词之间距离的时间复杂度是 O(ln^2)，这还不包括 dfs/bfs 每次遍历距离矩阵的时间
        ## 遍历替换单词每一个字母的时间复杂度是 O(26ln)，基于哈希表的 set 查找时间是 O(1)

        from queue import Queue
        class Solution:
            def ladderLength(self, beginWord: str, endWord: str, wordList: List[str]) -> int:
                wordSet = set(wordList)
                q = Queue()
                q.put((beginWord, 1))
                usedSet = set([beginWord])
                while not q.empty():
                    word, l = q.get()
                    if word == endWord:
                        return l
                    for i in range(len(word)):
                        ## 改变第 i 个字母
                        wordP1, wordP2 = word[:i], word[i+1:]
                        for c in "abcdefghijklmnopqrstuvwxyz":
                            nextWord = wordP1 + c + wordP2
                            if c != word[i] and nextWord not in usedSet and nextWord in wordSet:
                                usedSet.add(nextWord)
                                q.put((nextWord, l+1))
                return 0

- [LeetCode] Word Ladder II 单词接龙（最短路径集合）。Hint：如果直接在 BFS 的时候存储路径，需要很大的空间。首先用 BFS 确定路径长度，再用 DFS 沿着路径长度递减的方向查找。

  https://leetcode.com/problems/word-ladder-ii

  .. container:: toggle

    .. container:: header

        :math:`\color{darkgreen}{Code}`

    .. code-block:: python
        :linenos:

        ## bfs 从 endWord 出发，这样在 dfs 的时候从 beginWord 出发、沿着 dist 减小的方向一定是通向 endWord 的方向。
        ## 如果 bfs 从 beginWord 出发，那么 dfs 沿着 dist 增大的方向是发散的、不一定是通向 endWord 的方向。

        from queue import Queue
        class Solution:
            def findLadders(self, beginWord: str, endWord: str, wordList: List[str]) -> List[List[str]]:
                self.wordSet = set(wordList)
                self.wordSet.add(beginWord) ## beginWord 加入 wordSet，需要计算路径长度
                self.distDict = {} ## 存储 endWord 到其他 word 的路径长度
                self.bfs(endWord)  ## 从 endWord 出发
                res, seq = [], []
                self.dfs(beginWord, endWord, seq, res)
                return res

            def bfs(self, startWord):
                q = Queue()
                q.put((startWord, 0))
                self.distDict[startWord] = 0
                while not q.empty():
                    word, dist = q.get()
                    nextWordList = self.getNextWordList(word)
                    for nextWord in nextWordList:
                        if nextWord not in self.distDict:
                            q.put((nextWord, dist + 1))
                            self.distDict[nextWord] = dist + 1

            def dfs(self, beginWord, endWord, seq, res):
                seq.append(beginWord)
                if beginWord == endWord:
                    res.append(seq[:]) ## 注意：这里要对 seq 拷贝
                else:
                    nextWordList = self.getNextWordList(beginWord)
                    for nextWord in nextWordList:
                        if nextWord in self.distDict and self.distDict[nextWord] == self.distDict[beginWord] - 1:
                            self.dfs(nextWord, endWord, seq, res)
                seq.pop()

            def getNextWordList(self, word):
                nextWordList = []
                for i in range(len(word)):
                    wordP1, wordP2 = word[:i], word[i+1:]
                    for c in "abcdefghijklmnopqrstuvwxyz":
                        nextWord = wordP1 + c + wordP2
                        if c != word[i] and nextWord in self.wordSet:
                            nextWordList.append(nextWord)
                return nextWordList

