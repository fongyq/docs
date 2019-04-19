基本命令
============

文件和目录
--------------------

.. code-block:: bash

  cd ..
  pwd
  ls -a -F -R

  cp [-i] source destination
  cp -R

  mv src des
  rm -i -r -f folder

  touch new ## 创建新文件或修改文件时间属性

  mkdir new
  rmdir new

  file my_file ##查看文件类型

  cat -n log.txt
  tail log.txt
  head -5 log.txt

  WC file -c -w -l


磁盘空间
------------

.. code-block:: bash

  df -h
  du [-s] -h

处理数据文件
----------------

.. code-block:: bash

  sort [-n] log.txt

  grep [-n] [-c] t file ## find *t* in file

  gzip my*
  gunzip myfile.gz

  tar -cvf test.tar test/
  tar -xvf test.tar
  tar -xzvf test.tgz
