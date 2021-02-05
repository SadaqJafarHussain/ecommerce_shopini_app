module.exports = ({ env }) => ({
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', 5000),
  admin: {
    auth: {
      secret: env('ADMIN_JWT_SECRET', 'f35d5223fc8abff9dba4d6a5bcb00e86'),
    },
  },
});
