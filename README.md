# VestaCP PHP Multi Selector (CentOS 7, Remi Repo)

Bu script, VestaCP üzerinde CentOS 7 için PHP 5.6, 7.0, 7.1, 7.2, 7.3, 7.4, 8.0, 8.1, 8.2, 8.3 sürümlerini çoklu olarak kurup seçmenizi sağlar.

**Test Edilen Sistem:** CentOS 7 (Remi Repository ile)

## Açıklama
Bu script ile VestaCP'de cgi, fcgi veya fpm olarak birden fazla PHP sürümünü kolayca kurabilir ve kullanabilirsiniz.

## Kurulum Adımları

### 1. Remi Repository ve Gerekli Paketlerin Kurulumu
```bash
yum install -y epel-release yum-utils wget
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
```

### 2. Scriptlerden Birini Seçin ve Çalıştırın

#### cgi
```bash
wget https://github.com/muratbaslamis/vestacp-centos-multi-php-selector/vst-php-cgi.sh
chmod a+x ./vst-php-cgi.sh
sudo ./vst-php-cgi.sh
```

#### fcgi
```bash
wget https://github.com/muratbaslamis/vestacp-centos-multi-php-selector/vst-php-fcgid.sh
chmod a+x ./vst-php-fcgid.sh
sudo ./vst-php-fcgid.sh
```

#### fpm
```bash
wget https://github.com/muratbaslamis/vestacp-centos-multi-php-selector/vst-php-fpm.sh
chmod a+x ./vst-php-fpm.sh
sudo ./vst-php-fpm.sh
```

Script çalıştıktan sonra istediğiniz PHP sürümlerini (ör: 56 74 80) boşlukla ayırarak girin.

### 3. PHP Eklentilerini Kurma
Kurulan her PHP sürümü için eklentileri aşağıdaki gibi kurabilirsiniz:

```bash
yum install -y php74-php-mbstring php74-php-gd php74-php-intl php74-php-mysqlnd php74-php-xml php74-php-opcache
```

Başka bir sürüm için örnek:
```bash
yum install -y php80-php-mbstring php80-php-gd php80-php-intl php80-php-mysqlnd php80-php-xml php80-php-opcache
```

> Not: Her sürüm için başında ilgili sürüm kodu olmalı (php56-php-*, php70-php-*, php74-php-* gibi).

### 4. Servisleri Yeniden Başlatma
Kurulumdan sonra Apache (httpd) ve ilgili PHP-FPM servislerini yeniden başlatın:
```bash
systemctl restart httpd
systemctl restart php74-php-fpm # örnek, kullandığınız sürüme göre değiştirin
```

## Ekran Görüntüleri
![1](/screenshot/php_version.png)
![2](/screenshot/php.png)

## Kaynaklar
- [Remi Repository](https://rpms.remirepo.net/)
- [VestaCP Forum](https://forum.vestacp.com/viewtopic.php?f=41&t=20571)

---

**Not:**
- Scriptler ve şablonlar CentOS 7 ve Remi repo ile tam uyumludur.
- Ubuntu/Debian için eski sürümler README'nin önceki versiyonunda bulunabilir.
