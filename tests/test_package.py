import importlib.util
from pathlib import Path
import tempfile
import unittest
import zipfile

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('package', ROOT / 'scripts/package.py')
package = importlib.util.module_from_spec(spec)
spec.loader.exec_module(package)


class PackageTests(unittest.TestCase):
    def test_release_contains_install_files_and_license_only(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = package.build(Path(tmp) / 'release.zip')
            with zipfile.ZipFile(result) as archive:
                self.assertEqual(set(archive.namelist()), set(package.FILES))
                self.assertTrue(archive.read('install-helper.ps1').startswith(b'\xef\xbb\xbf'))
                self.assertIn(b'Copyright (c) 2026 88lin', archive.read('LICENSE'))
                self.assertNotIn(b'\n', archive.read('install.bat').replace(b'\r\n', b''))


if __name__ == '__main__':
    unittest.main()
