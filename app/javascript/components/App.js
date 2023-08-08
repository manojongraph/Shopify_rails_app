import { ApolloClient, ApolloProvider, createHttpLink, InMemoryCache } from '@apollo/client';
import { AppProvider, EmptyState, Page, Frame, Button} from '@shopify/polaris';
import { Provider } from '@shopify/app-bridge-react';
import enTranslations from '@shopify/polaris/locales/en.json';
import React from 'react';


export default function App() {

  const client = new ApolloClient({
    link: new createHttpLink({
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/graphql',
      },
    }),
    cache: new InMemoryCache()
  });

  const data = document.getElementById('shopify-app-init').dataset;

  const config = {
    apiKey: data.apiKey,
    shopOrigin: window.app.hostOrigin,
    host: new URLSearchParams(location.search).get("host")
  };

  return (
    <Provider config={config} >
      <AppProvider i18n={enTranslations}>
        <ApolloProvider client={client}>
          <Frame>
            <Page fullWidth>
             <h1>Hello World</h1>
            </Page>
          </Frame>
        </ApolloProvider>
      </AppProvider>
    </Provider>
  );
}
