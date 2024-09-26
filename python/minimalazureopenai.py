# how to switch from OpenAI to Azure OpenAI
# from: https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/switching-endpoints
import os
from openai import AzureOpenAI


api_version = "2024-07-01-preview"
endpoint = "https://xsv1domain.openai.azure.com/"

client = AzureOpenAI(
    api_version=api_version,
    azure_endpoint=endpoint,
    api_key=os.getenv("AZURE_OPENAI_API_KEY")   # Go to your Azure AI Service homepage in the portal to get the key
)


chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "Say this is a test",
        }
    ],
    model="gpt-4o-mini",
)


print(chat_completion)