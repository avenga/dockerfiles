const Koa = require('koa')
const app = new Koa()
const hello = require('./hello')

const port = 3000

app.use(async ctx => {
  ctx.body = hello()
})

app.listen(port, () => {
  console.log(`Listening on ${port}`)
})
