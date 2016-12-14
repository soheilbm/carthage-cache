Pod::Spec.new do |s|

  s.name         = "AES256Encrypter"
  s.version      = "0.0.3"
  s.summary      = "A simple category on NSData for AES256 encryption."
  s.description  = <<-DESC
                   AES256Encrypter provides methods to encrypt/decrypt NSData with a given key.

                   * It's based on the CommonCrypto framework included both in iOS and Mac OS.
                   * The task like encrypting a plist in Mac then decrypting it in iOS app 
                   * can be naturally done by it.
                   * 
                   DESC

  s.homepage     = "https://github.com/soheilbm/AES256Encrypter"
  s.license      = { :type => 'Unknown', :text => <<-LICENSE
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  LICENSE
  }
  s.author       = "David Hilowitz??"

  s.source       = { :git => "https://github.com/soheilbm/AES256Encrypter.git", :tag => "0.0.3" }

  s.source_files  = 'AES256Encrypter/NSDataAES256.{h,m}' 
  s.requires_arc  = true
end
