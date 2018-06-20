const test = require('tape')
const apiEndpoint = process.env.API_ENDPOINT
const request = require('supertest')(apiEndpoint)

test('hello API', (t) => {
  t.plan(1)
  request
    .get('/')
    .expect(200)
    .end((err, res) => {
      t.equal(res.text, 'Hello World')
    })
})
