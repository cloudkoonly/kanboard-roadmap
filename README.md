# Kanboard Roadmap

<p align="center">
  <h1 align="center">Kanboard Roadmap</h1>
  <p align="center">
    An open source system, including product roadmap, feedback, and changelog built on top of Kanboard.
    <br/>
    Perfect alternative to canny.io and featurebase.app
  </p>
</p>

<p align="center">
  <a href="https://roadmap.cloudkoonly.com/roadmap/">Online Demo</a> •
  <a href="#features">Features</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#requirements">Requirements</a> •
  <a href="#support">Support</a>
</p>

## 📝 Overview

Kanboard Roadmap is a comprehensive solution for managing product roadmaps, user feedback, and changelogs. Built on top of Kanboard, it provides a seamless experience for product teams and users alike.

## 🖥️ Demo

You can try out our demo site at: [https://roadmap.cloudkoonly.com/roadmap/](https://roadmap.cloudkoonly.com/roadmap/)

### Screenshots

![Demo Roadmap](https://file.cloudkoonly.com/data/kanborad-roadmap/roadmap-231240.png)
*Product Roadmap View*

![Demo Feedback](https://file.cloudkoonly.com/data/kanborad-roadmap/feedback2.png)
*User Feedback System*

![Demo Changelog](https://file.cloudkoonly.com/data/kanborad-roadmap/changelog2.png)
*Changelog Management*

## 🚀 Features

- **Public Roadmap Board**
  - Visual roadmap with customizable status columns
  - Feature voting and prioritization
  - Progress tracking
  - Tag-based categorization

- **User Feedback System**
  - Feedback submission portal
  - Upvoting mechanism
  - Comment threads
  - Status updates

- **Changelog Management**
  - Version-based release notes
  - Automatic changelog generation
  - Release date tracking
  - Feature categorization

## 🛠️ Requirements

- PHP 7.4+
- MySQL 5.7+ or MariaDB 10.2+
- Web server (lite-lnmp)
- Kanboard installation

## 🚀 Quick Start

1. Clone lite-lnmp repository:
```bash
git clone https://github.com/cloudkoonly/lite-lnmp.git
```

2. Navigate to the project directory:
```bash
cd lite-lnmp/app
```

3. Clone this repository to your Kanboard-roadmap directory:
```bash
git clone https://github.com/yourusername/kanboard-roadmap.git
cp kanboard-roadmap/db.sql ../mysql8/sql/
```

4. Create database and import sql file for roadmap:
```bash
mysql -uroot -p
CREATE DATABASE roadmap;
USE roadmap;
source /tmp/sql/db.sql;
```

5. Create nginx config:
```bash
cp kanboard-roadmap/nginx.conf /etc/nginx/conf.d/roadmap.conf
```

6. Add Hosts:
```bash
127.0.0.1 roadmap.dev
```

7. Restart lnmp:
```bash
docker-compose up -d
```

8. Access the roadmap:

- Frontend: `http://roadmap.dev/roadmap/`
- Admin: `http://roadmap.dev/` (username: admin, password: 123456) !important: change password after first login

## 🎯 Roadmap

View our public roadmap at `https://roadmap.cloudkoonly.com/roadmap/` to see what features we're planning.

## 💬 Support

- Create an issue in this repository
- Join our community discussions
- Email support: opensource@cloudkoonly.com

## ⭐ Why Choose This Over Alternatives?

- **Open Source**: Full control over your data and customization
- **Self-hosted**: Keep sensitive feedback and roadmap data in-house
- **Cost-effective**: No monthly subscription fees
- **Customizable**: Adapt the system to your specific needs
- **Privacy-focused**: Your data stays on your servers

## 📜 License

This project is licensed under the MIT License.

```
MIT License

Copyright (c) 2025 Kanboard Roadmap

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## ⚠️ Disclaimer

This software is provided "as is" without warranty of any kind, either express or implied. Use at your own risk. The author will not be liable for any damages arising from the use of this software.

The author makes no warranty that:
- The software will meet your requirements
- The software will be uninterrupted, timely, secure or error-free
- The results from the use of the software will be effective, accurate or reliable
- Any errors in the software will be corrected

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch
3. Submit a pull request

## 📝 Last updated: March 6, 2025
2025 [Cloudkoonly](https://www.cloudkoonly.com). All Rights Reserved.