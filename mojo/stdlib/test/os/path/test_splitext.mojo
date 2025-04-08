# ===----------------------------------------------------------------------=== #
# Copyright (c) 2025, Modular Inc. All rights reserved.
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
from os.path import splitext
from os.path.path import _split_extension
from testing import assert_equal


# TODO: Can't run on windows currently, so just test with Windows args.
def test_windows_path():
    head, extension = _split_extension(
        "C:\\path\\to\\my\\file.txt", "\\", "/", "."
    )
    assert_equal(head, "C:\\path\\to\\my\\file")
    assert_equal(extension, ".txt")

    head, extension = _split_extension("C:/path/to/my/file.txt", "\\", "/", ".")
    assert_equal(head, "C:/path/to/my/file")
    assert_equal(extension, ".txt")

    head, extension = _split_extension(
        "c:/path\\to/my\\file.txt", "\\", "/", "."
    )
    assert_equal(head, "c:/path\\to/my\\file")
    assert_equal(extension, ".txt")


def _splitext_test(
    path: String, expected_head: String, expected_extension: String
):
    head, extension = splitext(path)
    assert_equal(head, expected_head)
    assert_equal(extension, expected_extension)


def test_absolute_file_path():
    _splitext_test("/usr/lib/file.txt", "/usr/lib/file", ".txt")
    _splitext_test("//usr/lib/file.txt", "//usr/lib/file", ".txt")
    _splitext_test("///usr/lib/file.txt", "///usr/lib/file", ".txt")


def test_relative_file_path():
    _splitext_test("usr/lib/file.txt", "usr/lib/file", ".txt")
    _splitext_test("./file.txt", "./file", ".txt")
    _splitext_test(".././.././file.txt", ".././.././file", ".txt")


def test_relative_directories():
    _splitext_test("", "", "")
    _splitext_test(".", ".", "")
    _splitext_test("..", "..", "")
    _splitext_test("........", "........", "")
    _splitext_test("usr/lib", "usr/lib", "")


def test_file_names():
    _splitext_test("foo.bar", "foo", ".bar")
    _splitext_test("foo.boo.bar", "foo.boo", ".bar")
    _splitext_test("foo.boo.biff.bar", "foo.boo.biff", ".bar")
    _splitext_test(".csh.rc", ".csh", ".rc")
    _splitext_test("nodots", "nodots", "")
    _splitext_test(".cshrc", ".cshrc", "")
    _splitext_test("...manydots", "...manydots", "")
    _splitext_test("...manydots.ext", "...manydots", ".ext")


def main():
    test_absolute_file_path()
    test_relative_file_path()
    test_relative_directories()
    test_windows_path()
    test_file_names()
