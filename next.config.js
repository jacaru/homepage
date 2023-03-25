const { i18n } = require("./next-i18next.config");

/** @type {import('next').NextConfig} */
const nextConfig = {
  trailingSlash: true,
  basePath: process.env.NEXT_PUBLIC_BASEPATH || undefined,
  reactStrictMode: true,
  output: "standalone",
  swcMinify: false,
  images: {
    domains: ["cdn.jsdelivr.net"],
    unoptimized: true,
  },
  i18n,
};

module.exports = nextConfig;
