const { Client } = require('pg');

exports.handler = async (event, context) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  try {
    const data = JSON.parse(event.body);
    
    const client = new Client({
      connectionString: process.env.POSTGRES_URL,
      ssl: { rejectUnauthorized: false }
    });
    
    await client.connect();
    
    await client.query(`
      INSERT INTO prospects (email, first_name, last_name, company, source)
      VALUES ($1, $2, $3, $4, 'webhook')
      ON CONFLICT (email) DO UPDATE SET updated_at = CURRENT_TIMESTAMP
    `, [data.email, data.first_name, data.last_name, data.company]);
    
    await client.end();
    
    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ status: 'success' })
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};