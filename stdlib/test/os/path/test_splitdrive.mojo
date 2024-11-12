# ===----------------------------------------------------------------------=== #
# Copyright (c) 2024, Modular Inc. All rights reserved.
#
# Licensed under the Apache License v2.0 with LLVM Exceptions:
# https://llvm.org/LICENSE.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ===----------------------------------------------------------------------=== #
# RUN: %mojo %s

import os
from os.path import splitdrive
from testing import assert_equal


def test_with_mount():
    drive, path = splitdrive("C:/usr/lib/file.txt")
    assert_equal(drive, "C:")
    assert_equal(path, "/usr/lib/file.txt")


def test_absolute_path():
    drive, path = splitdrive("/usr/lib/file.txt")
    assert_equal(drive, "")
    assert_equal(path, "/usr/lib/file.txt")


def test_relative_path():
    drive, path = splitdrive("usr/lib/file.txt")
    assert_equal(drive, "")
    assert_equal(path, "usr/lib/file.txt")


def main():
    # test_with_mount()
    test_absolute_path()
    test_relative_path()
