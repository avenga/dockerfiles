const test = require('tape')
const hello = require(`${__dirname}/../../src/hello`)

test('hello Function', (t) => {
  t.plan(1)
  t.equal(hello(), 'Hello World')
})
